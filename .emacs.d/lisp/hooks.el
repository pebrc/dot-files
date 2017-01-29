;; (dolist (mode '(scheme emacs-lisp lisp clojure clojurescript))
;;   (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
;;               'paredit-mode))

(global-company-mode)
(global-auto-revert-mode t)
(window-numbering-mode)

;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;(add-hook 'clojure-mode-hook 'typed-clojure-mode)
;(add-hook 'cider-repl-mode-hook #'paredit-mode)

(setq shell-file-name "/bin/bash")
(setq org-directory "~/Dropbox/org")

