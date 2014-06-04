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
	1 to: remapBufferCount do:
		[:i | 
		oop := remapBuffer at: i.
		(self isIntegerObject: oop) ifFalse: [self markAndTrace: oop]].
	self markAndTraceTraceLogs