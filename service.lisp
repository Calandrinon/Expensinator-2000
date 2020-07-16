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


(defmethod save-expenses ((service Service))
	(write-repository-to-file (repository service)))


(defmethod load-expenses ((service Service))
	(read-expenses-from-file (repository service)))


(defmethod get-sum-of-expenses ((service Service))
	(let* ((container (get-container service))
		   (sum 0.0))
		(loop for expense in container
			do (setf sum (+ sum (price expense))))	
		sum))
