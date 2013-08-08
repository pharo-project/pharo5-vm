as yet unclassified
swapActiveContext: newContext restoreMethod: aMethodOop
	"swap active context with provided one,
	return old context pointer, or 0 on error"
	<export: true>
	| oldContext theFrame thePage | 
	
	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	oldContext := self ensureFrameIsMarried: framePointer SP: stackPointer.

	(self fetchClassOf: newContext) ~~ (self splObj: ClassMethodContext) ifTrue:
		[^0].
	aMethodOop ~= 0 ifTrue: [ newMethod := aMethodOop ].
	
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
	
	^oldContext