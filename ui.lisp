(load "service.lisp")
(load "~/quicklisp/setup.lisp")
(ql:quickload :cl-ppcre)
(ql:quickload :parse-float)
(use-package :parse-float)


(defclass UI ()
	((service 
	  :accessor service
	  :initarg :service)
	 (running
	  :accessor running
	  :initform 1)))


(defmethod ui-exit ((ui UI)) 
	(setf (running ui) 0)
	(exit))	


(defmethod ui-clearscreen ((ui UI)) 
	(loop for i from 1 to 100	
		do (terpri)))


(defmethod ui-add ((ui UI))
	(let* ((id 0)
		   (category "")
		   (product "")
		   (price 0))	
		(format t "Enter the id: ")	
		(finish-output)
		(setf id (read-from-string (read-line)))	

		(format t "Enter the category: ")	
		(finish-output)
		(setf category (read-line))	

		(format t "Enter the product name: ")	
		(finish-output)
		(setf product (read-line))	

		(format t "Enter the price: ")	
		(finish-output)
		(setf price (read-line))	
		(setf price (parse-float price))
		(add-expense id category product price (service ui))))


(defmethod ui-remove ((ui UI))
	(let* ((id 0))
		(format t "Enter the id: ")	
		(finish-output)
		(setf id (read-from-string (read-line)))	
		(remove-expense id (service ui))))


(defmethod ui-list ((ui UI))
	(let* ((container (get-container (service ui))))
		(loop for product in container
			do (display-expense product)
			)))


(defmethod ui-run ((ui UI))
	(let* ((command "")
		   (commands (list (cons 'exit #'ui-exit) (cons 'add #'ui-add) (cons 'list #'ui-list) (cons 'clear #'ui-clearscreen) (cons 'remove #'ui-remove)))
		   (tokens (list)))

		(loop for i from 1 to 50
			do (ui-clearscreen ui))		

		(loop while (= (running ui) 1)
			do (progn 
				(print '>>>)
				(finish-output)
				(setf command (read-line))
				(setf tokens (cl-ppcre:split "\\s+" command))
				(funcall (cdr (assoc (read-from-string (nth 0 tokens)) commands)) ui)))))
