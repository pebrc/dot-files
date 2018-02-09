;; global variables
(setq
 inhibit-startup-screen t
 use-package-always-ensure t
 use-package-verbose t
 shell-file-name "/bin/bash"
 org-directory "~/Dropbox/org"
 lispy-modes '(scheme emacs-lisp lisp clojure clojurescript cider-repl)
)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; modes
(electric-indent-mode +1)

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


;;(ace-jump-mode auto-complete better-defaults clj-refactor clojure-cheatsheet closure-lint-mode dash-at-point edn elisp-slime-nav ensime company exec-path-from-shell find-file-in-project groovy-mode helm helm-core idle-highlight-mode ido-ubiquitous ido-completing-read+ inflections js2-mode magit git-commit magit-popup markdown-mode+ markdown-mode modeline-posn multiple-cursors paradox hydra paredit peg popup rainbow-delimiters s sbt-mode scala-mode scala-mode2 smex swiper ivy typed-clojure-mode cider seq spinner queue pkg-info epl clojure-mode which-key window-numbering with-editor dash async yasnippet)


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
;(use-package window-numbering)
(use-package rainbow-delimiters
  :defer t
  :init
  (add-hooks lispy-modes 'rainbow-delimiters-mode))
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config (exec-path-from-shell-initialize))
(use-package markdown-mode)
(use-package ensime
  :disabled
  :ensure t
  :pin melpa-stable)

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(use-package etags-select
  :commands etags-select-find-tag)

(use-package multiple-cursors)
(use-package json-mode)
(use-package restclient)

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

;;
;; Customizations

(load-library "ekeys")
(load-library "hooks")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ensime-typecheck-idle-interval 1.5)
 '(gnutls-trustfiles
   (quote
    ("/etc/ssl/certs/ca-certificates.crt" "/etc/pki/tls/certs/ca-bundle.crt" "/etc/ssl/ca-bundle.pem" "/usr/ssl/certs/ca-bundle.crt" "/usr/local/share/certs/ca-root-nss.crt" "/Users/p_brc/Desktop/elastic-ce-aws.crt")))
 '(gnutls-verify-error (quote ((".*" nil))))
 '(linum-format "%4d │")
 '(markdown-command "multimarkdown")
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (terraform-mode ace-window multiple-cursors restclient projectile popup-imenu ensime json-mode markdown-mode ace-jump-mode)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
