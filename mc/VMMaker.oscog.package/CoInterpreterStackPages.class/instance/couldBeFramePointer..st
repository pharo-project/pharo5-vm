assertions
couldBeFramePointer: pointer
	"Answer if the argument is a properly aligned pointer into the stack zone."
	<var: #pointer type: #'void *'>
	^(pointer asUnsignedInteger bitAnd: objectMemory wordSize - 1) = 0
	   and: [pointer asUnsignedInteger
				between: (stackBasePlus1 - 1) asUnsignedInteger
				and: (self cCode: [pages asUnsignedInteger]
							inSmalltalk: [(self stackPageAt: 0) asUnsignedInteger])]