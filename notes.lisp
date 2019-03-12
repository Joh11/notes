;;;; notes.lisp

(in-package #:notes)

(defun main ()
  "The entry point of the program. For now display a blue square"
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :flags '(:shown) :title "Notes")
      (let ((renderer (sdl2:create-renderer win))
	    (painter (make-instance 'painter)))

	;; Register the painter
	(push painter *draw-list*)
	(sdl2:with-event-loop (:method :poll)
	  (:mousemotion (:x x :y y :state button)
			;; add a new rect to the list
			(unless (= 0 (logand button 1)) ;; if the left click is hold
			  (painter.add painter x y)))
	  (:idle ()
		 ;; TODO clean & update screen
		 ;; clear to black
		 (sdl2:set-render-draw-color renderer 0 0 0 255)
		 (sdl2:render-clear renderer)

		 ;; add the rectangle
		 (sdl2:set-render-draw-color renderer 0 0 255 255)
		 (loop :for e :in *draw-list* :do (draw e renderer))

		 ;; update screen
		 (sdl2:render-present renderer)

		 ;; make sure swank handles requests
		 (swank.live:update-swank))
	  (:quit () t))

	(sdl2:destroy-renderer renderer)))))
