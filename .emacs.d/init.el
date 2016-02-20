(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(defvar my-packages '(better-defaults
                      cider
                      clojure-mode
                      pkg-info
                      epl
                      dash
                      elisp-slime-nav
                      magit
                      ido-ubiquitous
                      smex
                      find-file-in-project
                      idle-highlight-mode
                      paredit))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;;
;; Customizations

(add-to-list 'load-path' "~/.emacs.d/lisp")
(load-library "efuncs")
(load-library "ekeys")
(load-library "hooks")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))



