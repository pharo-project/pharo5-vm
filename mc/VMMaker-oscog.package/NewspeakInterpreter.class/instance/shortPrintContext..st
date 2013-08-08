debug printing
shortPrintContext: aContext
	| home |
	<api>
	<inline: false>
	(self isContext: aContext) ifFalse:
		[self printHex: aContext; print: ' is not a context'; cr.
		^nil].
	home := self findHomeForContext: aContext.
	self printNum: aContext.
	self space.
	self printActivationNameFor: (self fetchPointer: MethodIndex ofObject: home)
		receiver: (self fetchPointer: ReceiverIndex ofObject: home)
		isBlock: home ~= aContext
		firstTemporary: (self fetchPointer: 0 + CtxtTempFrameStart ofObject: home).
	self cr