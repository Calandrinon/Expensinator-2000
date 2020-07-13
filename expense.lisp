(defclass Expense ()
	((id
	 :accessor id
	 :initarg :id)
	 (category
	 :accessor category
	 :initarg :category)
	 (expense-title 
	  :accessor expense-title
	  :initarg :expense-title)
	 (price
	  :accessor price
	  :initarg :price)))


(defmethod identical-expenses ((expense1 Expense) (expense2 Expense))
	(if (= (id expense1) (id expense2))
		t
		nil))


(defmethod display-expense ((expense Expense))
	(format t "-----------------------------------------------------------------------------------------~%ID: ~A | Category: ~A | Product name: ~A | Price: ~A~%-----------------------------------------------------------------------------------------~%" (id expense) (category expense) (expense-title expense) (price expense)))
