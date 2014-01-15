object memory support
mapInterpreterOops
	"Map all oops in the interpreter's state to their new values 
	during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	| oop |
	nilObj := self remap: nilObj.
	falseObj := self remap: falseObj.
	trueObj := self remap: trueObj.
	specialObjectsOop := self remap: specialObjectsOop.
	compilerInitialized
		ifFalse: [stackPointer := stackPointer - activeContext. "*rel to active"
			activeContext := self remap: activeContext.
			stackPointer := stackPointer + activeContext. "*rel to active"
			theHomeContext := self remap: theHomeContext].
	instructionPointer := instructionPointer - method. "*rel to method"
	method := self remap: method.
	instructionPointer := instructionPointer + method. "*rel to method"
	receiver := self remap: receiver.
	messageSelector := self remap: messageSelector.
	newMethod := self remap: newMethod.
	lkupClass := self remap: lkupClass.
	receiverClass := self remap: receiverClass.
	profileProcess := self remap: profileProcess.
	profileMethod := self remap: profileMethod.
	profileSemaphore := self remap: profileSemaphore.
	1 to: remapBufferCount do: [:i | 
			oop := remapBuffer at: i.
			(self isIntegerObject: oop)
				ifFalse: [remapBuffer at: i put: (self remap: oop)]].

	"Callback support - trace suspended callback list"
	1 to: jmpDepth do:[:i|
		oop := suspendedCallbacks at: i.
		(self isIntegerObject: oop) 
			ifFalse:[suspendedCallbacks at: i put: (self remap: oop)].
		oop := suspendedMethods at: i.
		(self isIntegerObject: oop) 
			ifFalse:[suspendedMethods at: i put: (self remap: oop)].
	].
