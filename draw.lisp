(in-package #:notes)

(defparameter *draw-list* nil)

(defgeneric draw (entity renderer)
  (:documentation "Specialize the entity param to draw any object on
  screen using render"))


(defmethod draw ((entity sdl2-ffi:sdl-rect) (renderer sdl2-ffi:sdl-renderer))
  (sdl2:render-fill-rect renderer entity))
