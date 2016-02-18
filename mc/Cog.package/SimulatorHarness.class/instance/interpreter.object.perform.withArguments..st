bootstrap methods
interpreter: sim object: receiver perform: selector withArguments: arguments
	"Interpret an expression in oldHeap using oldInterpreter.
	 Answer the result."
	| fp savedpc savedsp savedStackPages result startByteCount |
	self assert: ({receiver. selector}, arguments allSatisfy:
					[:oop| oop isInteger and: [sim objectMemory addressCouldBeOop: oop]]).
	savedpc := sim localIP.
	savedsp := sim localSP.
	savedStackPages := Set with: sim stackPage.
	sim internalPush: receiver.
	arguments do: [:arg| sim internalPush: arg].
	sim
		argumentCount: arguments size;
		messageSelector: selector.
	fp := sim localFP.
	startByteCount := sim byteCount.
	"sim byteCount = 66849 ifTrue: [self halt]."
	sim normalSend.
	sim incrementByteCount. "otherwise, send is not counted"
	["sim printFrame: sim localFP WithSP: sim localSP"
	 "sim setBreakSelector: #elementsForwardIdentityTo:"
	 "sim byteCount = 66849 ifTrue: [self halt]."
	 "(sim byteCount > 7508930 and: [sim localFP = -16r27894]) ifTrue:
		[self halt]."
	 fp = sim localFP] whileFalse:
		[sim singleStep.
		 (savedStackPages includes: sim stackPage) ifFalse: "If the stack gets deep something has probably gone wrong..."
			[savedStackPages size > 20 ifTrue: [self halt].
			 savedStackPages add: sim stackPage]].
	result := sim internalPopStack.
	self assert: savedsp = sim localSP.
	self assert: sim localIP - 1 = savedpc.
	sim localIP: savedpc.
	^result