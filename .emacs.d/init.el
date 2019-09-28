;; global variables
(setq
 inhibit-startup-screen t
 use-package-always-ensure t
 use-package-verbose t
 shell-file-name "/bin/bash"
 lispy-modes '(scheme emacs-lisp lisp clojure clojurescript cider-repl)
 backup-directory-alist `(("." . "~/.saves"))
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

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

(require 'use-package)

(add-to-list 'load-path' "~/.emacs.d/lisp")
(load-library "efuncs")

(set-frame-font "Menlo 14")

(use-package helm
  :ensure t
  :bind (("M-a" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-I" . helm-previous-page)
	      ("M-K" . helm-next-page)
	      ("M-h" . helm-beginning-of-buffer)
	      ("M-H" . helm-end-of-buffer))
  :config (progn
	    (setq helm-buffers-fuzzy-matching t)
        (helm-mode 1)))

(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds))

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
  :mode ("\\.\\(scala\\|sbt|sc\\)\\'" . scala-mode)
  :interpreter
  ("scala" . scala-mode))


(use-package multiple-cursors)
(use-package json-mode)
(use-package expand-region
  :bind ("C-=" . er/expand-region))
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
(use-package go-guru)
(use-package go-mode
  :ensure t
  :init
  (setq company-dabbrev-downcase nil)
  (setq gofmt-command "goimports")
  :bind (:map go-mode-map
         ("M-." . godef-jump))
  :config
  (add-hook 'before-save-hook #'gofmt-before-save)
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
  ;(add-hook 'go-mode-hook #'gorepl-mode)
  )

(use-package go-flycheck
  :load-path "~/go/src/github.com/dougm/goflymake"
  :commands goflymake)

(use-package flycheck
  :ensure t
  :pin melpa
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
  ;(ido-everywhere 1)
  (flx-ido-mode 1))

(use-package projectile
  :demand
  :init   (setq projectile-use-git-grep t)
  :config (projectile-global-mode t)
  :bind   (("H-f" . projectile-find-file)
           ("H-F" . projectile-grep)))

(use-package yaml-mode)
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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (misterioso)))
 '(ensime-sbt-perform-on-save "compile")
 '(ensime-startup-notification nil)
 '(ensime-typecheck-idle-interval 1.5)
 '(gnutls-verify-error (quote ((".*" nil))))
 '(go-play-browse-function (quote browse-url))
 '(linum-format "%4d │")
 '(markdown-command "multimarkdown")
 '(menu-bar-mode nil)
 '(org-babel-load-languages (quote ((scala . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (inf-clojure esup go-fill-struct expand-region evil-magit adoc-mode flymake-yaml flycheck-yamllint fish-mode magithub helm-files helm-descbinds helm dockerfile-mode auctex gorepl-mode gotest go-add-tags go-eldoc go-gen-test go-guru go-imports go-rename go-scratch go-tag slack switch-buffer-functions jinja2-mode yaml-mode org-tree-slide-mode org-tree-slide flycheck-rust toml-mode rust-mode company-go flycheck go-mode ace-window multiple-cursors restclient projectile popup-imenu ensime json-mode markdown-mode ace-jump-mode)))
 '(racer-rust-src-path
   "/Users/p_brc/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src")
 '(rust-format-on-save t)
 '(safe-local-variable-values
   (quote
    ((TeX-engine . xetex)
     (eval add-hook
           (quote switch-buffer-functions)
           (lambda
             (prev cur)
             (if
                 (and
                  (buffer-file-name cur)
                  (inf-clojure-proc)
                  (file-name-extension
                   (buffer-file-name cur))
                  (string=
                   (downcase
                    (file-name-extension buffer-file-name))
                   "cljs"))
                 (let
                     ((ns
                       (clojure-find-ns)))
                   (unless
                       (or
                        (not ns)
                        (equal ns ""))
                     (with-demoted-errors
                         (inf-clojure--send-string
                          (inf-clojure-proc)
                          (format
                           (inf-clojure-set-ns-form)
                           ns))))))))
     (eval add-hook
           (quote kill-buffer-hook)
           (lambda nil
             (if
                 (and buffer-file-name
                      (inf-clojure-proc)
                      (file-name-extension buffer-file-name)
                      (string=
                       (downcase
                        (file-name-extension buffer-file-name))
                       "cljs"))
                 (inf-clojure--send-string
                  (inf-clojure-proc)
                  "(require '[cloud.contexts :as contexts])(contexts/persist)"))))
     (eval command-execute
           (quote inf-clojure))
     (inf-clojure-repl-type quote planck)
     (inf-clojure-tools-deps-cmd . "planck -d -c src"))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
