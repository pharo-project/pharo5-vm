garbage collection
markAndTraceLiteral: literal in: cogMethodOrNil atpc: address
	"Mark and trace a literal in a machine code instruction preceding address in cogMethodOrNil.
	 Answer if code was modified."
	<var: #cogMethodOrNil type: #'CogMethod *'>
	<var: #address type: #usqInt>
	| objOop |
	(self couldBeObject: literal) ifFalse:
		[^false].
	self assert: (objectMemory addressCouldBeObj: literal).
	(objectMemory isForwarded: literal) ifFalse:
		[objectMemory markAndTrace: literal.
		 ^false].
	objOop := objectMemory followForwarded: literal.
	cogit backEnd storeLiteral: objOop beforeFollowingAddress: address.
	self markAndTraceUpdatedLiteral: objOop in: cogMethodOrNil.
	^true