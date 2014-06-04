object memory support
markAndTraceInterpreterOops
	"Mark and trace all oops in the interpreter's state."
	"Assume: All traced variables contain valid oops."
	| oop |
	self markAndTrace: specialObjectsOop. "also covers nilObj, trueObj, falseObj, and compact classes"
	self markAndTrace: activeContext.
	self markAndTrace: messageSelector.
	self markAndTrace: newMethod.
	self markAndTrace: lkupClass.
	self markAndTrace: receiverClass.
	self markAndTrace: profileProcess.
	self markAndTrace: profileMethod.
	self markAndTrace: profileSemaphore.

	1 to: remapBufferCount do: [:i | 
			oop := remapBuffer at: i.
			(self isIntegerObject: oop) ifFalse: [self markAndTrace: oop]].

	"Callback support - trace suspended callback list"
	1 to: jmpDepth do:[:i|
		oop := suspendedCallbacks at: i.
		(self isIntegerObject: oop) ifFalse:[self markAndTrace: oop].
		oop := suspendedMethods at: i.
		(self isIntegerObject: oop) ifFalse:[self markAndTrace: oop].
	].
