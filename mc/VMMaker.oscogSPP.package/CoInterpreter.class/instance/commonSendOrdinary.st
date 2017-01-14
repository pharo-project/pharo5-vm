send bytecodes
commonSendOrdinary
	"Send a message, starting lookup with the receiver's class."
	"Assume: messageSelector and argumentCount have been set, and that 
	the receiver and arguments have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	<sharedCodeNamed: 'commonSendOrdinary' inCase: #singleExtendedSendBytecode>
	self sendBreakpoint: messageSelector receiver: (self internalStackValue: argumentCount).
	cogit recordSendTrace ifTrue:
		[self recordTrace: (objectMemory classForClassTag: lkupClassTag)
			thing: messageSelector
			source: TraceIsFromInterpreter.
		cogit printOnTrace ifTrue:
			[self printActivationNameForSelector: messageSelector
				startClass: (objectMemory classForClassTag: lkupClassTag); cr]].
	self internalFindNewMethodOrdinary.
	self internalExecuteNewMethod.
	self fetchNextBytecode