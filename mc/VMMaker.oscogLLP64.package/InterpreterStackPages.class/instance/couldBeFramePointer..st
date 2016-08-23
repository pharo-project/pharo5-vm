assertions
couldBeFramePointer: pointer
	"Answer if the argument is a properly aligned pointer into the stack zone."
	<var: #pointer type: #'void *'>
	^self
		cCode:
			[(pointer asUnsignedInteger bitAnd: objectMemory wordSize - 1) = 0
			   and: [pointer asUnsignedInteger
						between: stackMemory asUnsignedInteger
						and: pages asUnsignedInteger]]
		inSmalltalk:
			[(pointer  bitAnd: objectMemory wordSize - 1) = 0
			 and: [(self memIndexFor: pointer)
					between: 1 and: stackMemory size]]