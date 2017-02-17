control primitives
primitivePerform
	<returnTypeC: #void>
	| newReceiver lookupClassTag performMethod |
	performMethod := newMethod.
	messageSelector := self stackValue: argumentCount - 1.
	newReceiver := self stackValue: argumentCount.

	"NOTE: the following lookup may fail and be converted to #doesNotUnderstand:,
	 so we must adjust argumentCount and slide args now, so that will work."

	"Slide arguments down over selector"
	argumentCount := argumentCount - 1.
	argumentCount to: 1 by: -1 do:
		[:i|
		stackPages
			longAt: stackPointer + (i * objectMemory wordSize)
			put: (stackPages longAt: stackPointer + ((i - 1) * objectMemory wordSize))].
	self pop: 1.
	lookupClassTag := objectMemory fetchClassTagOf: newReceiver.
	self sendBreakpoint: messageSelector receiver: newReceiver.
	self printSends ifTrue:
		[self printActivationNameForSelector: messageSelector
			startClass: (objectMemory classForClassTag: lookupClassTag); cr].
	self findNewMethodInClassTag: lookupClassTag.

	"Only test CompiledMethods for argument count - other objects will have to take their chances"
	((objectMemory isOopCompiledMethod: newMethod)
	  and: [(self argumentCountOf: newMethod) = argumentCount]) ifFalse:
		["Slide the args back up (sigh) and re-insert the selector."
		self unPop: 1.
		1 to: argumentCount by: 1 do:
			[:i |
			stackPages longAt: stackPointer + ((i - 1) * objectMemory wordSize)
				put: (stackPages longAt: stackPointer + (i * objectMemory wordSize))].
		stackPages longAt: stackPointer + (argumentCount * objectMemory wordSize) put: messageSelector.
		argumentCount := argumentCount + 1.
		newMethod := performMethod.
		^self primitiveFail].

	self executeNewMethod.
	"Recursive xeq affects primErrorCode"
	self initPrimCall