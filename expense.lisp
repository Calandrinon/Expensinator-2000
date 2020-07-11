(defclass Expense ()
	((expense-title 
	  :accessor expense-title
	  :initarg :expense-title)
	 (price
	  :accessor price
	  :initarg :price)))


(defmethod equal-expenses ((expense1 Expense) (expense2 Expense))
	(if (and
			(string-equal (expense-title expense1) (expense-title expense2))
			(= (price expense1) (price expense2)))
		t
		nil
	)) 

