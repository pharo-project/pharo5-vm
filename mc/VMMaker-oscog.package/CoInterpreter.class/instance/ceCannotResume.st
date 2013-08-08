trampolines
ceCannotResume
	<api>
	"A context that has been returned from, or otherwise has an invalid pc has been reentered.
	 Until we have a cannotResume: selector, simply resend cannotReturn:."
	| resultOop |
	self assert: (self isMachineCodeFrame: framePointer).
	self assert: (self frameHasContext: framePointer).
	resultOop := self stackTop.
	self push: (self frameContext: framePointer).
	self push: resultOop.
	"Make sure the happy couple remain returned from."
	self push: cogit ceCannotResumePC.
	^self
		ceSendAbort: (objectMemory splObj: SelectorCannotReturn)
		to: (self frameContext: framePointer)
		numArgs: 1