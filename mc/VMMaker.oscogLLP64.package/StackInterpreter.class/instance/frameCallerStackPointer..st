frame access
frameCallerStackPointer: theFP
	"Answer the stack pointer of the caller frame."
	<var: #theFP type: #'char *'>
	<returnTypeC: #'char *'>
	<inline: true>
	self assert: (self isBaseFrame: theFP) not.
	^theFP + (self frameStackedReceiverOffset: theFP) + objectMemory wordSize