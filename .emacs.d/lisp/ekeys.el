(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)
(global-set-key (kbd "C-`")  'cider-eval-expression-at-point-in-repl)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

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
