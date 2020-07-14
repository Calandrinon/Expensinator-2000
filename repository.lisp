(load "expense.lisp")
(load "~/quicklisp/setup.lisp")
(ql:quickload :cl-ppcre)
(ql:quickload :parse-float) 
(use-package :parse-float)

(defclass Repository () 
	((container
	 :accessor container
	 :initarg :container
	 :initform '())))	

(defmethod push-to-repository ((repo Repository) (expense Expense)) 
	(loop for it-expense in (container repo)
		do (progn
				(if (= (id it-expense) (id expense)) 
					(progn
					(format t "ERROR: Unable to insert a product with the same ID!")
					(return-from push-to-repository -1)))))	
	(push expense (container repo)))


(defmethod remove-from-repository (id (repo Repository))
	(defun remove-nth (index list)
			(let* ((deleted '()))
				(setf (nth index list) deleted)
				(remove deleted list)
				(remove NIL list)))

	(let* ((index 0))
		(loop for expense in (container repo)
			do 
			(if (= (id expense) id)
				(progn
					(remove-nth index (container repo))
					(setf (container repo) (remove nil (container repo)))
					(return))
				(setf index (+ index 1))))))


(defmethod get-repository-container ((repo Repository))
	(container repo))


(defmethod get-repository-size ((repo Repository))
	(list-length (container repo)))


(defmethod write-repository-to-file ((repo Repository))
	(with-open-file (str "expenses.txt"
							 :direction :output
							 :if-exists :supersede
							 :if-does-not-exist :create)
			(loop for expense in (container repo)
				do (progn  
					(format str "~A~%" (expense-to-csv-format expense))))))


(defmethod read-expenses-from-file ((repo Repository))
(let* ((filename "expenses.txt")
	   (tokens (list))
	   (id 0)
 	   (category "")
 	   (product "")
 	   (price 0)
	   (expense nil))

  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line do 
					(progn 
						(setf tokens (cl-ppcre:split "," line))
							(setf id (parse-integer (nth 0 tokens)))					
							(setf category (nth 1 tokens))					
							(setf product (nth 2 tokens))					
							(setf price (nth 3 tokens))
							(setf price (parse-float price))
							(setf expense (make-instance 'Expense :id id :category category :expense-title product :price price))
							(push-to-repository repo expense))))))
