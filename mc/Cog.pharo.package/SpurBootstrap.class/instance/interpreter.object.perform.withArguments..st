bootstrap methods
interpreter: sim object: receiver perform: selector withArguments: arguments
	"Interpret an expression in oldHeap using oldInterpreter.
	 Answer the result."
	| fp savedpc savedsp result startByteCount |
	savedpc := sim localIP.
	savedsp := sim localSP.
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
	["sim byteCount = 66849 ifTrue: [self halt]."
	 "(sim byteCount > 7508930 and: [sim localFP = -16r27894]) ifTrue:
		[self halt]."
	 fp = sim localFP] whileFalse:
		[sim singleStep].
	result := sim internalPopStack.
	self assert: savedsp = sim localSP.
	self assert: sim localIP - 1 = savedpc.
	sim localIP: savedpc.
	^result