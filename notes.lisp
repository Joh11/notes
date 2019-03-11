;;;; notes.lisp

(in-package #:notes)

(defparameter *draw-list* nil)
(defparameter *min-dist* 4)

(defun ^2 (x)
  (* x x))

(defun dist^2 (x1 y1 x2 y2)
  (+ (^2 (- x2 x1))
     (^2 (- y2 y1))))

(defun make-painter ()
  (let ((last-x 0)
	(last-y 0))
    (lambda (x y)
      (when (> (dist^2 last-x last-y x y) *min-dist*)
	;; add a new rect to the draw list
	(push (sdl2:make-rect x y 10 10) *draw-list*)))))

(defun main ()
  "The entry point of the program. For now display a blue square"
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :flags '(:shown) :title "Notes")
      (let ((renderer (sdl2:create-renderer win))
	    (painter (make-painter)))
	
	(sdl2:with-event-loop (:method :poll)
	  (:mousemotion (:x x :y y :state button)
			;; add a new rect to the list
			(unless (= 0 (logand button 1)) ;; if the left click is hold
			  (funcall painter x y)))
	  (:idle ()
		 ;; TODO clean & update screen
		 ;; clear to black
		 (sdl2:set-render-draw-color renderer 0 0 0 255)
		 (sdl2:render-clear renderer)

		 ;; add the rectangle
		 (sdl2:set-render-draw-color renderer 0 0 255 255)
		 (loop :for rect :in *draw-list* :do (sdl2:render-fill-rect renderer rect))

		 ;; update screen
		 (sdl2:render-present renderer)

		 ;; make sure swank handles requests
		 (swank.live:update-swank))
	  (:quit () t))

	(sdl2:destroy-renderer renderer)))))

