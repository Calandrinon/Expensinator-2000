(load "repository.lisp")

(defclass Service ()
	((repository
	  :accessor repository
	  :initarg :repository)))

(defmethod create-service ((repository Repository))
	(make-instance 'Service :repository repository))


(defmethod add-expense (title price (service Service))
	(let* ((expense (make-instance 'Expense :expense-title title :price price)))
	(push-to-repository (repository service) expense)))


(defmethod get-container ((service Service))
	(get-repository-container (repository service)))

