trampolines
ceInterpretMethodFromPIC: aMethodObj receiver: rcvr
	<api>
	| pic primitiveIndex |
	<var: #pic type: #'CogMethod *'>
	"pop off inner return and locate open or closed PIC"
	pic := self cCoerceSimple: self popStack - cogit interpretOffset to: #'CogMethod *'.
	self assert: (pic cmType = CMOpenPIC or: [pic cmType = CMClosedPIC]).
	"If found from an open PIC then it must be an uncogged method and, since it's been found
	 in the method cache, should be cogged if possible.  If found from a closed PIC then at the
	 time the closed PIC was created the method was uncoggable, either because there was
	 no space, it had too many literals or it contained an illegal bytecode).  So don't try and cog
	 it, but subsequently it may have been cogged via another path.  If the method is, or ends up
	 cogged, jump to machine code, otherwise interpret."
	pic cmType = CMOpenPIC ifTrue:
		[self assert: (self methodHasCogMethod: aMethodObj) not.
		 (self methodShouldBeCogged: aMethodObj) ifTrue:
			[cogit cog: aMethodObj selector: pic selector]].
	(self methodHasCogMethod: aMethodObj) ifTrue:
		[self executeCogMethod: (self cogMethodOf: aMethodObj)
			fromUnlinkedSendWithReceiver: rcvr
		 "NOTREACHED"].
	messageSelector := pic selector.
	newMethod := aMethodObj.
	primitiveIndex := self primitiveIndexOf: aMethodObj.
	primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: objectMemory nilObject.
	argumentCount := pic cmNumArgs.
	instructionPointer := self popStack.
	^self interpretMethodFromMachineCode
	"NOTREACHED"