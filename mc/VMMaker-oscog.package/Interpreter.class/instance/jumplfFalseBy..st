jump bytecodes
jumplfFalseBy: offset 
	| boolean |
	boolean := self internalStackTop.
	boolean = falseObj
		ifTrue: [self jump: offset]
		ifFalse: [boolean = trueObj
				ifFalse: [messageSelector := self splObj: SelectorMustBeBoolean.
					argumentCount := 0.
					^ self normalSend].
			self fetchNextBytecode].
	self internalPop: 1