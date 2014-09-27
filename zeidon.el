;; Define lod viewer for vml mode
(defun create-lod-view (sName)
  (interactive "sLod Name: " sName)
  (create-lod-view-buffer sName))

(defun create-lod-view-buffer(sName)
  (setq sLod (concat "*LOD " sName " View*"))
  (message "Buffer window: %s" sLod)
  (if (get-buffer sLod)
      (kill-buffer sLod))
  (generate-new-buffer sLod)
  (change-to-viewer sLod)
  (goto-char (point-min))
  (insert "|--------------------------------------------|\n")
  (insert "| Logical Object Definition Viewer for Emacs |\n")
  (insert "|--------------------------------------------|\n")
 )

(defun extract-word ()
  (let ((begin (point)))
    (forward-word)
    (kill-ring-save begin (point)))
)

(defun get-lod-for-viewer ()
  (interactive)
  (extract-word)
  (change-to-viewer)
  (yank)
)

(defun change-to-viewer (sLod)
  (switch-to-buffer-other-window sLod))


(defun build-lod-name (&optional arg)
  (interactive "sLod Name: " arg)
  (setq sName (concat "*" arg "*")))


