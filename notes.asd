;;;; notes.asd

(asdf:defsystem #:notes
  :description "Describe notes here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:sdl2
	       #:swank.live)
  :components ((:file "package")
               (:file "notes")))

