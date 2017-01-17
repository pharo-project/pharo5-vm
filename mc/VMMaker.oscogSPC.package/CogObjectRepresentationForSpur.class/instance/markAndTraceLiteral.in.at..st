garbage collection
markAndTraceLiteral: literal in: cogMethod at: address
	"Mark and trace a literal in a sqInt variable of cogMethod."
	<var: #cogMethod type: #'CogMethod *'>
	<var: #address type: #'sqInt *'>
	| objOop |
	(self couldBeObject: literal) ifFalse:
		[^self].
	self assert: (objectMemory addressCouldBeObj: literal).
	(objectMemory isForwarded: literal) ifFalse:
		[objectMemory markAndTrace: literal.
		 ^self].
	objOop := objectMemory followForwarded: literal.
	address at: 0 put: objOop.
	self markAndTraceUpdatedLiteral: objOop in: cogMethod