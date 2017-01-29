;;
;; Never understood why Emacs doesn't have this function. nicked from steveyegge
;;
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn 	 (rename-file name new-name 1)
                 (rename-buffer new-name)
                 (set-visited-file-name new-name)
                 (set-buffer-modified-p nil))))))

(defun cider-eval-expression-at-point-in-repl ()
  (interactive)
  (let ((form (cider-sexp-at-point)))
    ;; Strip excess whitespace
    (while (string-match "\\`\s+\\|\n+\\'" form)
      (setq form (replace-match "" t t form)))
    (set-buffer (cider-current-repl-buffer))
    (goto-char (point-max))
    (insert form)
    (cider-repl-return)))

(defun cider-figwheel ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
        (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
             ;;(figwheel-sidecar.repl-api/cljs-repl)")
        (cider-repl-return)))

(defun cider-figwheel-repl ()
  (interactive)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(figwheel-sidecar.repl-api/cljs-repl)")
    (cider-repl-return)))
