trampolines
ceMNUFromPICMNUMethod: aMethodObj receiver: rcvr
	<api>
	| cPIC primitiveIndex |
	<var: #cPIC type: #'CogMethod *'>
	self assert: (objectMemory addressCouldBeOop: rcvr).
	self assert: (aMethodObj = 0
				or: [(objectMemory addressCouldBeObj: aMethodObj)
					and: [objectMemory isOopCompiledMethod: aMethodObj]]).
	cPIC := self cCoerceSimple: self popStack - cogit mnuOffset to: #'CogMethod *'.
	self assert: (cPIC cmType = CMClosedPIC or: [cPIC cmType = CMOpenPIC]).
	argumentCount := cPIC cmNumArgs.
	messageSelector := cPIC selector.
	aMethodObj ~= 0 ifTrue:
		[instructionPointer := self popStack.
		self createActualMessageTo: (objectMemory fetchClassOf: rcvr).
		(self maybeMethodHasCogMethod: aMethodObj) ifTrue:
			[self push: instructionPointer.
			 self executeCogMethod: (self cogMethodOf: aMethodObj)
				 fromUnlinkedSendWithReceiver: rcvr.
			 "NOTREACHED"
			 self assert: false].
		newMethod := aMethodObj.
		primitiveIndex := self primitiveIndexOf: aMethodObj.
		primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: objectMemory nilObject.
		^self interpretMethodFromMachineCode].
	"handleMNU:InMachineCodeTo:classForMessage: assumes lkupClass is set, since every other use is
	 after a lookupMethodNoMNUEtcInClass: call, which sets lkupClass.  Here we must set it manually.
	 Global variables.  Bah!"
	self handleMNU: SelectorDoesNotUnderstand
		InMachineCodeTo: rcvr
		classForMessage: (lkupClass := objectMemory fetchClassOf: rcvr).
	"NOTREACHED"
	self assert: false