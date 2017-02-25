disassembly
disassembleMethodFor: pc
	<doNotGenerate>
	| method |
	method := methodZone methodFor: pc.
	(method isNil or: [method isZero]) ifTrue:
		[self error: 'not a method'].
	self disassembleMethod: method