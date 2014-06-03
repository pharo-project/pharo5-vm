send bytecodes
commonSend
	"Send a message, starting lookup with the receiver's class."
	"Assume: messageSelector and argumentCount have been set, and that 
	the receiver and arguments have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	<sharedCodeNamed: 'commonSend' inCase: #singleExtendedSendBytecode>
	self sendBreakpoint: messageSelector receiver: (self internalStackValue: argumentCount).
	self printSends ifTrue:
		[self printActivationNameForSelector: messageSelector startClass: (objectMemory classForClassTag: lkupClassTag); cr].
	self internalFindNewMethod.
	self internalExecuteNewMethod.
	self fetchNextBytecode