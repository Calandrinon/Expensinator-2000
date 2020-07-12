(load "service.lisp")

(defclass UI ()
	((service 
	  :accessor service
	  :initarg :service)
	 (running
	  :accessor running
	  :initform t)
	))


(defmethod ui-run ((ui UI))
	(let* ((command ""))
		(loop while (running ui)
			do	(progn 
					(print '>>>)
					(finish-output)
					(setf command (read-line)))				
		)
	)
)
