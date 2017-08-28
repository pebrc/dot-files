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
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(unless (package-installed-p 'use-package)
    (package-install 'use-package))

(require 'use-package)

(add-to-list 'load-path' "~/.emacs.d/lisp")
(load-library "efuncs")


;;(ace-jump-mode auto-complete better-defaults clj-refactor clojure-cheatsheet closure-lint-mode dash-at-point edn elisp-slime-nav ensime company exec-path-from-shell find-file-in-project groovy-mode helm helm-core idle-highlight-mode ido-ubiquitous ido-completing-read+ inflections js2-mode magit git-commit magit-popup markdown-mode+ markdown-mode modeline-posn multiple-cursors paradox hydra paredit peg popup rainbow-delimiters s sbt-mode scala-mode scala-mode2 smex swiper ivy typed-clojure-mode cider seq spinner queue pkg-info epl clojure-mode which-key window-numbering with-editor dash async yasnippet)


(use-package cider
  :defer t)
(use-package elisp-slime-nav
  :defer t)
(use-package magit
  :defer t)
(use-package smex)
(use-package ido-ubiquitous)
(use-package paredit
  :defer t
  :init
  (add-hooks lispy-modes 'paredit-mode))
(use-package company)
(use-package window-numbering)
(use-package rainbow-delimiters
  :defer t
  :init
  (add-hooks lispy-modes 'rainbow-delimiters-mode))
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config (exec-path-from-shell-initialize))
(use-package markdown-mode)
;;
;; Customizations

(load-library "ekeys")
(load-library "hooks")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "multimarkdown")
 '(menu-bar-mode nil)
 '(package-selected-packages (quote (ace-jump-mode)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
