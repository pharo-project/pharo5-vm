frame access
frameCallerContext: theFP
	"In the StackInterpreter the saved ip field of a base frame holds the base
	 frame's caller context. But in the Cog VM the first word on the stack holds
	 the base frame's caller context, which is immediately above the stacked
	 receiver.  The asserts using frameStackedReceiverOffset: are simulation
	 only since they depend on being able to access numArgs and frameContext
	 from the frame's method and in a base return the frame state, being below
	 the stack pointer, may have already been smashed by an interrupt."
	| thePage |
	self assert: (self isBaseFrame: theFP).
	thePage := stackPages stackPageFor: theFP.
	self assert: theFP + (self frameStackedReceiverOffset: theFP) + (2 * objectMemory wordSize) = thePage baseAddress.
	self assert: (stackPages longAt: thePage baseAddress - objectMemory wordSize) = (self frameContext: theFP).
	^super frameCallerContext: theFP