(load "repository.lisp")

(defclass Service ()
	((repository
	  :accessor repository
	  :initarg :repository)))

(defmethod create-service ((repository Repository))
	(make-instance 'Service :repository repository))


(defmethod add-expense (id category title price (service Service))
	(let* ((expense (make-instance 'Expense :id id :category category :expense-title title :price price)))
	(push-to-repository (repository service) expense)))


(defmethod remove-expense (id (service Service))
	(remove-from-repository id (repository service)))


(defmethod update-expense (id category title price (service Service)) 
	(remove-from-repository id (repository service))	
	(push-to-repository (repository service) (make-instance 'Expense :id id :category category :expense-title title :price price)))


(defmethod get-container ((service Service))
	(get-repository-container (repository service)))

