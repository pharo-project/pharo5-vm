common selector sends
bytecodePrimSize
	| rcvr sz |
	successFlag := true.
	rcvr := self internalStackTop.
	self assertClassOf: rcvr is: (self splObj: ClassArray).
	successFlag ifTrue:[
		sz := self lengthOf: rcvr.
		self internalPop: 1 thenPush: (self integerObjectOf: sz).
		^self fetchNextBytecode].
	messageSelector := self specialSelector: 18.
	argumentCount := 0.
	self normalSend