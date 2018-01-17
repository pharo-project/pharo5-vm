private
operator: char
	| myself |
	myself := (Smalltalk at: (Operators at: char)) newFrom: self.
	myself setOperator: char.
	^ myself