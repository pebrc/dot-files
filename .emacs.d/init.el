(require 'package)

(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(defvar my-packages '(clojure-test-mode
                      cider
                      clojure-mode
                      pkg-info
                      epl
                      dash
                      starter-kit-bindings
                      starter-kit-eshell
                      starter-kit-lisp
                      elisp-slime-nav
                      starter-kit
                      magit
                      git-rebase-mode
                      git-commit-mode
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
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
 (setq exec-path (append exec-path (list "/opt/local/bin/" )))

