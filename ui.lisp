(load "service.lisp")
(load "~/quicklisp/setup.lisp")
(ql:quickload :cl-ppcre)

(defclass UI ()
	((service 
	  :accessor service
	  :initarg :service)
	 (running
	  :accessor running
	  :initform 1)))


(defmethod ui-exit ((ui UI)) 
	(setf (running ui) 0))	


(defmethod ui-run ((ui UI))
	(let* ((command "")
		   (commands (list (cons 'exit #'ui-exit)))
		   (tokens (list)))
		(loop while (= (running ui) 1)
			do (progn 
				(print '>>>)
				(finish-output)
				(setf command (read-line))
				(setf tokens (cl-ppcre:split "\\s+" command))
				(funcall (cdr (assoc (read-from-string (nth 0 tokens)) commands)) ui)
				))))

