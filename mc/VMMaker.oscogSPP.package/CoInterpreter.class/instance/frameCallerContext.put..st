frame access
frameCallerContext: theFP put: aValue
	"In the StackInterpreter the saved ip field of a base frame holds the
	 base frame's caller context. But in the Cog VM the first word on the
	 stack holds the base frame's caller context, which is immediately
	 above the stacked receiver."
	<var: #theFP type: #'char *'>
	self assert: (self isBaseFrame: theFP).
	self assert: theFP + (self frameStackedReceiverOffset: theFP) + (2 * objectMemory wordSize) = (stackPages stackPageFor: theFP) baseAddress.
	self assert: (stackPages longAt: theFP + (self frameStackedReceiverOffset: theFP) + objectMemory wordSize) = (self frameContext: theFP).
	^stackPages
		longAt: theFP + (self frameStackedReceiverOffset: theFP) + (2 * objectMemory wordSize)
		put: aValue