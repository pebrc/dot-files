;;(global-set-key (kbd "C-`")  'cider-eval-expression-at-point-in-repl)

(global-set-key (kbd "<f5>") 'replace-last-sexp)

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
