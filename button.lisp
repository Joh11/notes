(in-package #:notes)

(defparameter *buttons* nil)

(defclass button ()
  ((on-click
    :initarg :on-click
    :reader button.on-click)
   (rect
    :initarg :rect
    :accessor button.rect))) ;; TODO choosing button (default 1, left click)

(defmethod draw ((entity button) (renderer sdl2-ffi:sdl-renderer))
  (sdl2:set-render-draw-color renderer 0 255 0 255)
  (sdl2:render-fill-rect renderer (button.rect entity)))

(defun free-button (button)
  (delete-if (lambda (other-button)
	       (eq other-button button))
	     *buttons*))

(defun make-button (x y w h &key (on-click (lambda ())))
  (make-instance 'button :on-click on-click :rect (sdl2:make-rect x y w h)))

(defun make-registered-button (x y w h &key (on-click (lambda ())))
  (let ((button (make-button x y w h :on-click on-click)))
    (push button *buttons*)
    button))

(defun buttons-click (pressedp button-type x y)
  ;; TODO for now only care about pressed buttons
  (loop :for button :in *buttons* :do
     (if (collision? (button.rect button) x y)
	 (funcall (button.on-click button)))))

(defun collision? (rect x y)
  (and (inside? x [ (sdl2:rect-x rect) (+ (sdl2:rect-x rect) (sdl2:rect-width rect)) ])
       (inside? y [ (sdl2:rect-y rect) (+ (sdl2:rect-y rect) (sdl2:rect-height rect)) ])))
