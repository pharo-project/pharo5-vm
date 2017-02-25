growing/shrinking memory
methodHeaderOf: methodObj
	"Answer the method header of a CompiledMethod object.
	 If the method has been cogged then the header is a pointer to
	 the CogMethod and the real header will be stored in the CogMethod."
	<api>
	<inline: true>
	| header |
	self assert: (self isCompiledMethod: methodObj).
	header := self fetchPointer: HeaderIndex ofObject: methodObj.
	^(self isIntegerObject: header)
		ifTrue: [header]
		ifFalse:
			[self assert: header asUnsignedInteger < newSpaceStart.
			 self assert: (coInterpreter cCoerceSimple: header to: #'CogMethod *') objectHeader
						= self nullHeaderForMachineCodeMethod.
			(coInterpreter cCoerceSimple: header to: #'CogMethod *') methodHeader]