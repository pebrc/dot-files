(global-company-mode)
(global-auto-revert-mode t)

(when (and (string= "darwin" system-type)
           (not (memq window-system '(mac ns))))
  (setq interprogram-cut-function 'mac-cut-function)
  (setq interprogram-paste-function 'mac-paste-function))
