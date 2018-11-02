;; global variables
(setq
 inhibit-startup-screen t
 use-package-always-ensure t
 use-package-verbose t
 shell-file-name "/bin/bash"
 org-directory "~/Dropbox/org"
 lispy-modes '(scheme emacs-lisp lisp clojure clojurescript cider-repl)
 inf-clojure-program "planck"
)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; global keybindings
(global-unset-key (kbd "C-z"))

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/")
                    ("elpy" . "http://jorgenschaefer.github.io/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(unless (package-installed-p 'use-package)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'use-package))

(require 'use-package)

(add-to-list 'load-path' "~/.emacs.d/lisp")
(load-library "efuncs")

(set-frame-font "Menlo 14")

(use-package ace-window)
(use-package cider
  :defer t)
(use-package elisp-slime-nav
  :defer t)
(use-package magit
  :defer t)
(use-package smex)
(use-package ido-completing-read+)
(use-package paredit
  :defer t
  :init
  (add-hooks lispy-modes 'paredit-mode))
(use-package company)
(use-package company-go
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))

(use-package window-numbering)

(use-package rainbow-delimiters
  :defer t
  :init
  (add-hooks lispy-modes 'rainbow-delimiters-mode))
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config (exec-path-from-shell-initialize))
(use-package markdown-mode)
(use-package ensime
  :pin melpa-stable
  :bind (:map ensime-mode-map
              ("C-c C-v f" . scalafmt-file)))

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(use-package etags-select
  :commands etags-select-find-tag)

(use-package multiple-cursors)
(use-package json-mode)
(use-package restclient)
(use-package racer)
(use-package flycheck-rust)
(use-package rust-mode
  :bind (:map rust-mode-map
              ("TAB" . company-indent-or-complete-common))
  :init
  (setq company-tooltip-align-annotations t)
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode))
(use-package go-mode
  :ensure t
  :bind (:map go-mode-map
         ("M-." . godef-jump))
  :config
  (add-hook 'before-save-hook #'gofmt-before-save))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package org-tree-slide
  :after (org)
  :bind (:map org-mode-map
              ("<f8>" . org-tree-slide-mode)
              ("S-<f8>" . org-tree-slide-skip-done-toggle)
              :map org-tree-slide-mode-map
              ("C-<right>" . org-tree-slide-move-next-tree)
              ("C-<left>" . org-tree-slide-move-previous-tree))
  :init
  (org-tree-slide-simple-profile))

(use-package python
  :ensure t
  :defer t
  :mode ("\\.py\\'" . python-mode))

(use-package elpy
  :ensure t
  :init (with-eval-after-load 'python (elpy-enable))
  :after python
  :config (elpy-enable))

(use-package smartparens
  :diminish smartparens-mode
  :commands
  smartparens-strict-mode
  smartparens-mode
  sp-restrict-to-pairs-interactive
  sp-local-pair
  :init
  (setq sp-interactive-dwim t)
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)

  (sp-pair "(" ")" :wrap "C-(") ;; how do people live without this?
  (sp-pair "[" "]" :wrap "s-[") ;; C-[ sends ESC
  (sp-pair "{" "}" :wrap "C-{")

  ;; WORKAROUND https://github.com/Fuco1/smartparens/issues/543
  (bind-key "C-<left>" nil smartparens-mode-map)
  (bind-key "C-<right>" nil smartparens-mode-map)

  (bind-key "s-<delete>" 'sp-kill-sexp smartparens-mode-map)
  (bind-key "s-<backspace>" 'sp-backward-kill-sexp smartparens-mode-map))

(use-package flx-ido
  :demand
  :init
  (setq
   ido-enable-flex-matching t
   ;; C-d to open directories
   ;; C-f to revert to find-file
   ido-show-dot-for-dired nil
   ido-enable-dot-prefix t)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1))

(use-package projectile
  :demand
  :init   (setq projectile-use-git-grep t)
  :config (projectile-global-mode t)
  :bind   (("s-f" . projectile-find-file)
           ("s-F" . projectile-grep)))
;;
;; Customizations

(load-library "ekeys")
(load-library "hooks")

;; modes
(electric-indent-mode +1)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ensime-sbt-perform-on-save "compile")
 '(ensime-typecheck-idle-interval 1.5)
 '(gnutls-trustfiles
   (quote
    ("/etc/ssl/certs/ca-certificates.crt" "/etc/pki/tls/certs/ca-bundle.crt" "/etc/ssl/ca-bundle.pem" "/usr/ssl/certs/ca-bundle.crt" "/usr/local/share/certs/ca-root-nss.crt" "/Users/p_brc/Desktop/elastic-ce-aws.crt")))
 '(gnutls-verify-error (quote ((".*" nil))))
 '(inf-clojure-lein-cmd "planck -c src")
 '(inf-clojure-tools-deps-cmd "planck -c src")
 '(linum-format "%4d │")
 '(markdown-command "multimarkdown")
 '(menu-bar-mode nil)
 '(org-babel-load-languages (quote ((scala . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (org-tree-slide-mode org-tree-slide flycheck-rust toml-mode rust-mode company-go flycheck go-mode ace-window multiple-cursors restclient projectile popup-imenu ensime json-mode markdown-mode ace-jump-mode)))
 '(racer-rust-src-path
   "/Users/p_brc/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src")
 '(rust-format-on-save t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
