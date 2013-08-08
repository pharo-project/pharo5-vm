jump bytecodes
jumplfTrueBy: offset 
	| boolean |
	boolean := self internalStackTop.
	boolean = trueObj
		ifTrue: [self jump: offset]
		ifFalse: [boolean = falseObj
				ifFalse: [messageSelector := self splObj: SelectorMustBeBoolean.
					argumentCount := 0.
					^ self normalSend].
			self fetchNextBytecode].
	self internalPop: 1