;;;; notes.lisp

(in-package #:notes)

(defun main ()
  "The entry point of the program. For now display a blue square"
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :flags '(:shown) :title "Notes")
      (let ((renderer (sdl2:create-renderer win))
	    (rect (sdl2:make-rect 20 20 30 30)))
	
	(sdl2:with-event-loop (:method :poll)
	  (:idle ()
		 ;; TODO clean & update screen
		 ;; clear to black
		 (sdl2:set-render-draw-color renderer 0 0 0 255)
		 (sdl2:render-clear renderer)

		 ;; add the rectangle
		 (sdl2:set-render-draw-color renderer 0 0 255 255)
		 (sdl2:render-fill-rect renderer rect)

		 ;; update screen
		 (sdl2:render-present renderer)

		 ;; make sure swank handles requests
		 (swank.live:update-swank)
		 )
	  (:quit () t))

	(sdl2:destroy-renderer renderer)))))

