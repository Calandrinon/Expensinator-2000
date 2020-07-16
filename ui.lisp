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


(defmethod ui-help ((ui UI))
	(format t "Commands:~%")
	(format t "		- add [adds a new expense]~%")
	(format t "		- remove [removes an expense]~%")
	(format t "		- update [updates an expense]~%")
	(format t "		- list [displays all the expenses on the screen]~%")
	(format t "		- exit [exits the program]~%")
	(format t "		- clear [clears the screen]~%")
	(format t "		- help [displays this message]~%"))


(defmethod ui-exit ((ui UI)) 
	(setf (running ui) 0)
	(save-expenses (service ui))
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


(defmethod ui-update ((ui UI))
	(let* ((id 0)
		   (category "")
		   (product "")
		   (price 0))	
		(format t "Enter the id: ")	
		(finish-output)
		(setf id (read-from-string (read-line)))	

		(format t "Enter the new category: ")	
		(finish-output)
		(setf category (read-line))	

		(format t "Enter the new product name: ")	
		(finish-output)
		(setf product (read-line))	

		(format t "Enter the new price: ")	
		(finish-output)
		(setf price (read-line))	
		(setf price (parse-float price))
		(update-expense id category product price (service ui))))


(defmethod ui-sum-of-expenses ((ui UI)) 
	(format t "Total of expenses: ~a~%" (get-sum-of-expenses (service ui))))


(defmethod ui-run ((ui UI))
	(load-expenses (service ui))
	(let* ((command "")
		   (commands (list (cons 'exit #'ui-exit) (cons 'add #'ui-add) (cons 'list #'ui-list) (cons 'clear #'ui-clearscreen) (cons 'remove #'ui-remove) (cons 'help #'ui-help) (cons 'update #'ui-update) (cons 'total #'ui-sum-of-expenses)))
		   (tokens (list)))
		(loop for i from 1 to 50
			do (ui-clearscreen ui))		
		(loop while (= (running ui) 1)
			do (progn 
				(print '>>>)
				(finish-output)
				(setf command (read-line))
				(setf tokens (cl-ppcre:split "\\s+" command))
				(handler-case (funcall (cdr (assoc (read-from-string (nth 0 tokens)) commands)) ui)
					(ALEXANDRIA:SIMPLE-PARSE-ERROR (c)
						(format t "The price should be a real number!~%")))))))
