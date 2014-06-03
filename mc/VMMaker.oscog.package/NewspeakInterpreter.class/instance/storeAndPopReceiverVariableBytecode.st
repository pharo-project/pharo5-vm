stack bytecodes
storeAndPopReceiverVariableBytecode
	"Note: This code uses storePointerUnchecked:ofObject:withValue: and does the 
	 store check explicitly in order to help the translator produce better code."
	| rcvr top |
	<expandCases>
	self
		cCode: "this bytecode will be expanded so that refs to currentBytecode below will be constant"
			[rcvr := receiver.
			 top := self internalStackTop.
			 (self isObjImmutable: rcvr) ifTrue:
				[self internalPop: 1.
				 self internalCannotAssign: top to: receiver withIndex: (currentBytecode bitAnd: 7)].
			 "cannot fetch next bytecode until after immutability check so pc is correct (set to
			  following bytecode, not the bytecode after that) after attemptToAssign:withIndex:"
			 self fetchNextBytecode.
			 rcvr < youngStart ifTrue:
				[self possibleRootStoreInto: rcvr value: top].
			 self storePointerUnchecked: (currentBytecode bitAnd: 7) ofObject: rcvr withValue: top.
			 self internalPop: 1]
		inSmalltalk: "Interpreter version has fetchNextBytecode out of order"
			[rcvr := receiver.
			 top := self internalStackTop.
			 (self isObjImmutable: rcvr) ifTrue:
				[self internalPop: 1.
				 self internalCannotAssign: top to: receiver withIndex: (currentBytecode bitAnd: 7)].
			 rcvr < youngStart ifTrue:
				[self possibleRootStoreInto: rcvr value: top].
			 self storePointerUnchecked: (currentBytecode bitAnd: 7) ofObject: rcvr withValue: top.
			 self internalPop: 1.
			 self fetchNextBytecode]