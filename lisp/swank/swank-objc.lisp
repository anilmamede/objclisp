(cl:defpackage objclisp
  (:use :cl)
  (:documentation "Brigde between objective-c and lisp")
  (:export start-swank))

(cl:in-package objclisp)

(load (make-pathname :directory (concatenate 'string (directory-namestring 
						      *load-pathname*) "/lisp/swank") 
		     :name "swank-loader"))
(swank-loader:init)

(defun start-swank (&optional (port 6002))
  (swank:create-server :style :spawn :dont-close t :port port))

swank:*COMMUNICATION-STYLE*
