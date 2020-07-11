(load "expense.lisp")

(defclass Repository () 
	((container
	 :accessor container
	 :initarg :container
	 :initform '())))	

(defmethod push-to-repository ((repo Repository) (expense Expense)) 
	(push expense (container repo)))


(defmethod remove-from-repository (title price (repo Repository))
	(defun remove-nth (index list)
			(let* ((deleted '()))
				(setf (nth index list) deleted)
				(remove deleted list)
				(remove NIL list)))

	(let* ((expense-to-remove (make-instance 'Expense :expense-title title :price price))
		   (index 0))	
		(loop for expense in (container repo)
			do 
			(if (equal-expenses expense expense-to-remove)
				(progn
					(remove-nth index (container repo))
					(setf (container repo) (remove nil (container repo)))
					(return))
				(setf index (+ index 1))))))

(defmethod get-repository-container ((repo Repository))
	(container repo))


(defmethod get-repository-size ((repo Repository))
	(list-length (container repo)))
