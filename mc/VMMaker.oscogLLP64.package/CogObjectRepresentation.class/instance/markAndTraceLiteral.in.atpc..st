garbage collection
markAndTraceLiteral: literal in: cogMethodOrNil atpc: address
	"Mark and trace a literal in a machine code instruction preceding address in cogMethodOrNil.
	 Answer if code was modified."
	<var: #cogMethodOrNil type: #'CogMethod *'>
	<var: #address type: #usqInt>
	self subclassResponsibility