(load "expense.lisp")

(defclass Repository () 
	((container
	 :accessor container
	 :initarg :container
	 :initform '())))	

(defmethod push-to-repository ((repo Repository) (expense Expense)) 
	(push expense (container repo)))

(defmethod get-repository-container ((repo Repository))
	(container repo))

(defmethod get-repository-size ((repo Repository))
	(list-length (container repo)))
