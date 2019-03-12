(in-package #:notes)

(defclass painter ()
  ((rect-list
    :initform nil
    :accessor painter.rect-list)
   (min-dist
    :initform 4
    :initarg :min-dist)
   (size
    :initform 10
    :initarg :size
    :accessor painter.size)))

(defmethod draw ((entity painter) (renderer sdl2-ffi:sdl-renderer))
  (loop :for r :in (painter.rect-list entity) :do (draw r renderer)))

(defun painter.add (painter x y)
  ;; TODO add dist check
  (push (sdl2:make-rect x y (painter.size painter) (painter.size painter))
	(painter.rect-list painter)))
