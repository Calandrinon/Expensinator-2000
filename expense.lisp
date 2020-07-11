(defclass Expense ()
	((expense-title 
	  :accessor expense-title
	  :initarg :expense-title)
	 (price
	  :accessor price
	  :initarg :price)))
