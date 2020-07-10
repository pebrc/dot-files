;;(global-set-key (kbd "C-`")  'cider-eval-expression-at-point-in-repl)

(global-set-key (kbd "<f5>") 'replace-last-sexp)
(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;; emacs-mac

(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(hyper z)] 'undo)

(setq ns-function-modifier 'hyper)

;; mac switch meta key
(defun mac-switch-meta nil 
  "switch meta between Option and Command"
  (interactive)
  (if
      (eq mac-option-modifier nil)
      (progn
        (setq mac-option-modifier 'meta)
        (setq mac-command-modifier 'hyper))
    (progn 
      (setq mac-option-modifier nil)
      (setq mac-command-modifier 'meta))
    )
)

;;Mac OS X iterm/tmux weirdness
(when (and (string= "darwin" system-type)
           (not (memq window-system '(mac ns))))
  (define-key input-decode-map "\e[1;5C" [C-right])
  (define-key input-decode-map "\e[1;5A" [C-up])
  (define-key input-decode-map "\e[1;5B" [C-down])
  (define-key input-decode-map "\e[1;5C" [C-right])
  (define-key input-decode-map "\e[1;5D" [C-left])

  (define-key input-decode-map "\e[1;4C" [M-right])
  (define-key input-decode-map "\e[1;4A" [M-up])
  (define-key input-decode-map "\e[1;4B" [M-down])
  (define-key input-decode-map "\e[1;4C" [M-right])
  (define-key input-decode-map "\e[1;4D" [M-left])

  (define-key input-decode-map "\e[1;8C" [C-M-right])
  (define-key input-decode-map "\e[1;8A" [C-M-up])
  (define-key input-decode-map "\e[1;8B" [C-M-down])
  (define-key input-decode-map "\e[1;8C" [C-M-right])
  (define-key input-decode-map "\e[1;8D" [C-M-left])

  (define-key input-decode-map "\e[1;0D" [M-S-left]))
