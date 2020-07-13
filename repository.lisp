(load "expense.lisp")

(defclass Repository () 
	((container
	 :accessor container
	 :initarg :container
	 :initform '())))	

(defmethod push-to-repository ((repo Repository) (expense Expense)) 
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
