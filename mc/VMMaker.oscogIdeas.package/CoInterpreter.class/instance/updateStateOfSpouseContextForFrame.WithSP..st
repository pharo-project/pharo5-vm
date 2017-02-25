frame access
updateStateOfSpouseContextForFrame: theFP WithSP: theSP
	"Update the frame's spouse context with the frame's current state except for the
	 sender and instruction pointer, which are used to mark the context as married."
	| theContext tempIndex pointer argsPointer |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #pointer type: #'char *'>
	<var: #argsPointer type: #'char *'>
	self assert: (self frameHasContext: theFP).
	theContext := self frameContext: theFP.
	self assert: (objectMemory isContext: theContext).
	self assert: (self frameReceiver: theFP)
				= (objectMemory noFixupFollowField: ReceiverIndex ofObject: theContext).
	(self isMachineCodeFrame: theFP)
		ifTrue:
			[tempIndex := self mframeNumArgs: theFP.
			 pointer := theFP + FoxMFReceiver - objectMemory wordSize]
		ifFalse:
			[tempIndex := self iframeNumArgs: theFP.
			 pointer := theFP + FoxIFReceiver - objectMemory wordSize].
	"update the arguments. this would appear not to be strictly necessary, but is for two reasons.
	 First, the fact that arguments are read-only is only as convention in the Smalltalk compiler;
	 other languages may choose to modify arguments.
	 Second, the Squeak runUntilErrorOrReturnFrom: nightmare pops the stack top, which may, in
	 certain circumstances, be the last argument, and hence the last argument may not have been
	 stored into the context."
	argsPointer := theFP + (self frameStackedReceiverOffsetNumArgs: tempIndex).
	1 to: tempIndex do:
		[:i|
		argsPointer := argsPointer - objectMemory wordSize.
		self assert: (objectMemory addressCouldBeOop: (stackPages longAt: argsPointer)).
		 objectMemory storePointer: ReceiverIndex + i
			ofObject: theContext
			withValue: (stackPages longAt: argsPointer)].
	"now update the non-argument stack contents."
	[pointer >= theSP] whileTrue:
		[self assert: (objectMemory addressCouldBeOop: (stackPages longAt: pointer)).
		 tempIndex := tempIndex + 1.
		 objectMemory storePointer: ReceiverIndex + tempIndex
			ofObject: theContext
			withValue: (stackPages longAt: pointer).
		 pointer := pointer - objectMemory wordSize].
	self assert: ReceiverIndex + tempIndex < (objectMemory lengthOf: theContext).
	objectMemory storePointerUnchecked: StackPointerIndex
		ofObject: theContext
		withValue: (objectMemory integerObjectOf: tempIndex)