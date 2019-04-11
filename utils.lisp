(in-package #:notes)

(defmacro inside? (x left a b right)
  (unless (and (or (equal left '[)
		   (equal left ']))
	       (or (equal right '[)
		   (equal right '])))
    (error "left and right should be [ or ]"))
  
  `(and (,(if (equal left '[) '>= '>) ,x ,a)
	(,(if (equal right ']) '<= '<) ,x ,b)))
