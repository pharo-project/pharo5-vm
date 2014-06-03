trampolines
ceInterpretMethodFromPIC: aMethodObj receiver: rcvr
	<api>
	| pic primitiveIndex |
	<var: #pic type: #'CogMethod *'>
	self assert: (self methodHasCogMethod: aMethodObj) not.
	"pop off inner return and locate open PIC"
	pic := self cCoerceSimple: self popStack - cogit interpretOffset to: #'CogMethod *'.
	self assert: (pic cmType = CMOpenPIC or: [pic cmType = CMClosedPIC]).
	"If found from an open PIC then it must be an uncogged method and, since it's been found
	 in the method cache, should be cogged if possible.  If found from a closed PIC it should
	 be interpreted (since being reached by that route implies it is uncoggable)."
	pic cmType = CMOpenPIC
		ifTrue:
			[(self methodShouldBeCogged: aMethodObj) ifTrue:
				[cogit cog: aMethodObj selector: pic selector.
				 (self methodHasCogMethod: aMethodObj) ifTrue:
					[self executeCogMethod: (self cogMethodOf: aMethodObj)
						fromUnlinkedSendWithReceiver: rcvr]]]
		ifFalse:
			[self assert: (cogCompiledCodeCompactionCalledFor
						or: [(cogit methodShouldBeCogged: aMethodObj) not])].
	messageSelector := pic selector.
	newMethod := aMethodObj.
	primitiveIndex := self primitiveIndexOf: aMethodObj.
	primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: objectMemory nilObject.
	argumentCount := pic cmNumArgs.
	instructionPointer := self popStack.
	^self interpretMethodFromMachineCode
	"NOTREACHED"