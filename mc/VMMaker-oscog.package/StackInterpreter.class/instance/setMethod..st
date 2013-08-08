internal interpreter access
setMethod: aMethodObj
	"Set the method and determine the bytecode set based on the method header's sign.
	 If MULTIPLEBYTECODESETS then a negative header selects the alternate bytecode set.
	 Conditionalizing the code on MULTIPLEBYTECODESETS allows the header sign bit to be
	 used for other experiments."
	<inline: true>
	method := aMethodObj.
	self assert: (objectMemory isOopCompiledMethod: method).
	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [bytecodeSetSelector := (self methodUsesAlternateBytecodeSet: method)
											ifTrue: [256]
											ifFalse: [0]]