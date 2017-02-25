garbage collection
markAndTraceCacheTagLiteral: literal in: cogMethodOrNil atpc: address
	"Mark and trace a literal in an inline cache preceding address in cogMethodOrNil.
	 Answer if code was modified."
	<var: #cogMethodOrNil type: #'CogMethod *'>
	<var: #address type: #usqInt>
	self subclassResponsibility