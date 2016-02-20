(dolist (mode '(scheme emacs-lisp lisp clojure clojurescript))
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
              'paredit-mode))

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'clojure-mode-hook 'typed-clojure-mode)
