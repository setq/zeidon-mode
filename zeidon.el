;; Define lod viewer for vml mode
(defun create-lod-viewer (sLodName)
  (interactive "sLod Name: " sLodName)
  (create-lod-view-buffer sLodName)
)

;; Generate the empty shell for the new lod viewer
(defun create-lod-view-buffer(sLodName)
  (setq sLodView (concat "*LOD " sLodName " View*"))
  (setq sRootName sLodName)
  (if (get-buffer sLodView)
      (kill-buffer sLodView))
  (generate-new-buffer sLodView)
  (create-lod-view-header)
  (load-lod)
  (get-parent-friendly-name)
 ; (set-buffer sLodView)
 ; (insert sParentName)
  (generate-parent-entity)
)

;; Generate the header for the newly created lod
(defun create-lod-view-header ()
  (switch-to-buffer-other-window sLodView)
  (goto-char 1)
  (insert "--------------------------------------------------------------------------\n")
  (insert " Logical Object Definition Viewer for Emacs\n")
  (insert "--------------------------------------------------------------------------\n")
  (insert " Viewing LOD: " sRootName ".LOD\n")
  (insert "--------------------------------------------------------------------------\n\n")
)

(defun load-lod ()
  (setq sLoadedLod (concat sRootName ".LOD"))
  (if (get-buffer sLoadedLod)
      (kill-buffer sLoadedLod))
  (setq sPath (concat "~/Projects/emacs/zeidon/src/" sRootName ".LOD"))
  (find-file-noselect sPath)
)

(defun get-parent-friendly-name ()
  (if (not (bufferp sLoadedLod))
      (set-buffer sLoadedLod))
    (goto-char (point-min))
  (let ((aKey "eLOD_EntityParent")
	(bKey "aName"))
    (search-forward aKey)
    (search-forward bKey)
    (skip-chars-forward " ")
    (setq sParentName (extract-word)))
)

(defun generate-parent-entity ()
  (if (not (bufferp sLodView))
       (set-buffer sLodView))
  (insert "Parent Entity: " sParentName)
  (insert "\n---\n\tTODO: Properties for parent\n---\n")
  (insert "Attributes\n")
  (get-entity-id sParentName)
  (insert sRootName "." sParentName "." sEntityID)
)

;; Utility Functions

;; Extract Word
(defun extract-word ()
  (let ((begin (point)))
    (forward-word)
    (buffer-substring-no-properties begin (point)))
)

(defun get-entity-id (sKey)
  (if (not (bufferp sLoadedLod))
      (set-buffer sLoadedLod))
  (setq sKeyID (concat sKey "ID"))
  (search-forward sKeyID)
  (search-backward "aName")
  (forward-word)
  (skip-chars-forward " ")
  (setq sEntityID (extract-word))
  (set-buffer sLodView)
)

;(Defun create-lod-view (sName)
;  (interactive "sLod Name: " sName)
;  (create-lod-view-buffer sName)
;)

;(defun create-lod-view-buffer(sName)
;  (setq sLod (concat "*LOD " sName " View*"))
;  (setq sRoot sName)
;  (if (get-buffer sLod)
;      (kill-buffer sLod))
;  (generate-new-buffer sLod)
;  (change-to-viewer sLod)
;  (insert "--------------------------------------------------------------------------\n")
;  (insert " Logical Object Definition Viewer for Emacs\n")
;  (insert "--------------------------------------------------------------------------\n")
;  (insert " Viewing LOD: " sName ".LOD\n")
;  (insert "--------------------------------------------------------------------------\n\n")
;  (load-lod sName)
;  (message "Buffer window: %s" sLod)
;  (build-lod-view-buffer sName sLod)
;)

;(defun load-lod (sName)
;  (setq szPath (concat "~/Projects/emacs/zeidon/src/" sName ".LOD"))
;  (find-file-noselect szPath)
;)

;(defun build-lod-view-buffer(sName sLod)
;  (setq sReadBuf (concat sName ".LOD"))
;  (get-parent-entity-name sReadBuf)
;  (change-to-viewer sLod)
;  (goto-char (point-max))
;  (insert "Parent Entity: " sParentName)
;  (insert "\n---\n\tProperties for parent\n---\n")
;  (insert "Attributes\n")
;  (get-parent-attributes sReadBuf sLod sName sParentName)
;  (get-next-child-entity-name sReadBuf)
;  (change-to-viewer sLod)
;  (goto-char (point-max))
;  (insert "Child Entity: " sParentName "." sChildName)
;  (insert "\n---\n\tProperties for child\n---\n")
;  (insert "Attributes\n")
;)

;(defun get-parent-entity-name (sReadBuf)
;  (change-to-viewer sReadBuf)
;  (let ((aKey "eLOD_EntityParent")
;	(bKey "aName"))
;    (search-forward aKey)
;    (search-forward bKey)
;    (skip-chars-forward " ")
;    (setq sParentName (extract-word)))
;)
;
;(defun get-next-child-entity-name (sReadBuf)
;  (change-to-viewer sReadBuf)
;  (let ((aKey "eLOD_EntityChild")
;	(bKey "aName"))
;    (search-forward aKey)
;    (search-forward bKey)
;    (skip-chars-forward " ")
;    (setq sChildName (extract-word)))
;)

;(defun get-parent-attributes(sReadBuf sWriteBuf sRoot sParentName)
;  (change-to-viewer sReadBuf)
;  (let ((aKey (concat sParentName "ID"))
;	(bKey "eER_AttributeRec")
;	(cKey "aName")
;	(search-forward aKey))) 
    

;  (let ((aKey "eLOD_EntityChild")
;	(bKey "eER_RelTypeRec")
;	(cKey "eER_AttributeRec")
;	(dKey "aName"))
;	(while (search-forward aKey nil t))
;	(search-forward bKey)
;	(while (search-forward cKey nil t)
;	  (search-forward dKey)
;	  (skip-chars-forward " ")
;	  (setq sAttrName (extract-word))
;	  (switch-to-buffer-other-window sWriteBuf)
;	  (goto-char (point-max))
;	  (insert sRoot "." sParentName "." sAttrName "\n")
;	  (switch-to-buffer-other-window sReadBuf)) 
;)

;(defun extract-word ()
;  (let ((begin (point)))
;    (forward-word)
;    (buffer-substring-no-properties begin (point)))
;)

;(defun change-to-viewer (sLodBuffer)
;  (switch-to-buffer-other-window sLodBuffer)
;  (goto-char (point-min))
;)


