trampolines
ceMNUFromPICMNUMethod: aMethodObj receiver: rcvr
	<api>
	| cPIC primitiveIndex |
	<var: #cPIC type: #'CogMethod *'>
	self assert: ((objectMemory isIntegerObject: rcvr) or: [objectMemory addressCouldBeObj: rcvr]).
	self assert: (aMethodObj = 0
				or: [(objectMemory addressCouldBeObj: aMethodObj)
					and: [objectMemory isOopCompiledMethod: aMethodObj]]).
	cPIC := self cCoerceSimple: self popStack - cogit mnuOffset to: #'CogMethod *'.
	self assert: cPIC cmType = CMClosedPIC.
	argumentCount := cPIC cmNumArgs.
	messageSelector := cPIC selector.
	aMethodObj ~= 0 ifTrue:
		[instructionPointer := self popStack.
		self createActualMessageTo: (objectMemory fetchClassOf: rcvr).
		(self maybeMethodHasCogMethod: aMethodObj) ifTrue:
			[self push: instructionPointer.
			 self executeCogMethodFromUnlinkedSend: (self cogMethodOf: aMethodObj)
				 withReceiver: rcvr.
			 "NOTREACHED"
			 self assert: false].
		newMethod := aMethodObj.
		primitiveIndex := self primitiveIndexOf: aMethodObj.
		primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: objectMemory nilObject.
		^self interpretMethodFromMachineCode].
	lkupClass := objectMemory fetchClassOf: rcvr.
	self handleMNU: SelectorDoesNotUnderstand InMachineCodeTo: rcvr classForMessage: lkupClass.
	"NOTREACHED"
	self assert: false