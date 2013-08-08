callback support
swapActiveContext: newContext restoreMethod: aMethodOop
	"swap active context with provided one,
	return old context pointer, or 0 on error"
	<export: true>
	| oldContext theFrame thePage calledFromMachineCode | 
	<var: #theFrame type: #'char *'>
	<var: #thePage type: #'StackPage *'>

	calledFromMachineCode := instructionPointer <= objectMemory startOfMemory.

	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	oldContext := self ensureFrameIsMarried: framePointer SP: stackPointer.

	(self isContext: newContext) ifFalse: [^0].
	(self isMarriedOrWidowedContext: newContext) ifTrue:
		[self assert: (self checkIsStillMarriedContext: newContext currentFP: framePointer)].
	
	aMethodOop ~= 0 ifTrue: [ 
		newMethod := aMethodOop. 
		argumentCount := self argumentCountOf: newMethod.
	].
	
	(self isStillMarriedContext: newContext)
		ifTrue:
			[theFrame := self frameOfMarriedContext: newContext.
			 thePage := stackPages stackPageFor: theFrame]
		ifFalse:
			[thePage := self makeBaseFrameFor: newContext.
			 theFrame := thePage baseFP].
	self assert: thePage headFP = theFrame.
	self setStackPageAndLimit: thePage.
	stackPointer := thePage headSP.
	framePointer := thePage headFP.
	(self isMachineCodeFrame: framePointer) ifFalse:
		[self setMethod: (self iframeMethod: framePointer)].

	instructionPointer := self popStack.

	(self isMachineCodeFrame: framePointer) ifTrue:
		[instructionPointer >= objectMemory startOfMemory ifTrue:
			[self iframeSavedIP: framePointer put: instructionPointer.
			 instructionPointer := cogit ceReturnToInterpreterPC]]
		ifFalse:
			[ self assert: instructionPointer > objectMemory startOfMemory].
		
	^oldContext