; The request was:
;   1. Hide Original Text layer
;   2. Duplicate Text Layer (that's visible)
;   3. Layer to Image Size Duplicate text layer

; After changing the script remember to do Filters -> Script-Fu -> Refresh Scripts.

(define (script-fu-ctext image drawable)

  (if (= (car (gimp-item-is-group drawable)) TRUE)
    (begin
      (gimp-message "Choose a layer not a layer group.")
      (quit)))

  (gimp-image-undo-group-start image)
  (gimp-item-set-visible drawable FALSE)

  (let* ((new-layer (car (gimp-layer-copy drawable FALSE))))
    (gimp-image-insert-layer image new-layer 0 -1)
    (gimp-item-set-visible new-layer TRUE)
    (gimp-layer-resize-to-image-size new-layer)
  )

  (gimp-image-undo-group-end image)
  (gimp-displays-flush)
)

(script-fu-register
  "script-fu-ctext"                          ; Name
  "Script-fu to optimally adjust text layer before applying a GEGL text style."                                   ; Menu label
  "Some stuff for contrast_"                 ; Description
  "teapot"                                   ; Author
  "Copyright"                                ; Copyright
  "Feb 2024"                                 ; Date
  "RGBA"                                     ; Types
  SF-IMAGE      "Input image"           0
  SF-DRAWABLE   "Input drawable"        0
)

(script-fu-menu-register "script-fu-ctext" "<Image>/Filters/Generic")
