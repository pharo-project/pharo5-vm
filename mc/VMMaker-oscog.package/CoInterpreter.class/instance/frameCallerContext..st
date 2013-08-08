frame access
frameCallerContext: theFP
	"In the StackInterpreter the saved ip field of a base frame holds the
	 base frame's caller context. But in the Cog VM the first word on the
	 stack holds the base frame's caller context, which is immediately
	 above the stacked receiver."
	<var: #theFP type: #'char *'>
	| thePage callerContextOrNil |
	<var: #thePage type: #'StackPage *'>
	self assert: (self isBaseFrame: theFP).
	thePage := stackPages stackPageFor: theFP.
	callerContextOrNil := stackPages longAt: thePage baseAddress.
	self assert: (objectMemory addressCouldBeObj: callerContextOrNil).
	self assert: (callerContextOrNil = objectMemory nilObject or: [objectMemory isContext: callerContextOrNil]).
	^callerContextOrNil