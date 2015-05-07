object memory support
markAndTraceStackPage: thePage
	| theSP theFP frameRcvrOffset callerFP oop |
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #frameRcvrOffset type: #'char *'>
	<var: #callerFP type: #'char *'>
	<inline: false>

	self assert: (stackPages isFree: thePage) not.
	self assert: (self ifCurrentStackPageHasValidHeadPointers: thePage).
	self assert: thePage trace ~= StackPageTraced.
	thePage trace: StackPageTraced.

	theSP := thePage headSP.
	theFP := thePage  headFP.
	"Skip the instruction pointer on top of stack of inactive pages."
	thePage = stackPage ifFalse:
		[theSP := theSP + objectMemory wordSize].
	[frameRcvrOffset := self frameReceiverLocation: theFP.
	 [theSP <= frameRcvrOffset] whileTrue:
		[oop := stackPages longAt: theSP.
		 (objectMemory isOopForwarded: oop) ifTrue:
			[oop := objectMemory followForwarded: oop.
			 stackPages longAt: theSP put: oop].
		 (objectMemory isImmediate: oop) ifFalse:
			[objectMemory markAndTrace: oop].
		 theSP := theSP + objectMemory wordSize].
	(self frameHasContext: theFP) ifTrue:
		[self assert: (objectMemory isContext: (self frameContext: theFP)).
		 objectMemory markAndTrace: (self frameContext: theFP)].
	(self isMachineCodeFrame: theFP)
		ifTrue: [self markAndTraceMachineCodeMethod: (self mframeCogMethod: theFP)]
		ifFalse: [objectMemory markAndTrace: (self iframeMethod: theFP)].
	(callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
		[theSP := theFP + FoxCallerSavedIP + objectMemory wordSize.
		 theFP := callerFP].
	theSP := theFP + FoxCallerSavedIP + objectMemory wordSize. "caller ip is ceBaseReturnPC"
	[theSP <= thePage baseAddress] whileTrue:
		[oop := stackPages longAt: theSP.
		 (objectMemory isOopForwarded: oop) ifTrue:
			[oop := objectMemory followForwarded: oop.
			 stackPages longAt: theSP put: oop].
		 (objectMemory isImmediate: oop) ifFalse:
			[objectMemory markAndTrace: oop].
		 theSP := theSP + objectMemory wordSize]