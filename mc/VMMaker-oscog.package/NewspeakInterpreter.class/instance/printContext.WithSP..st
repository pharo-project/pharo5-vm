debug printing
printContext: aContext WithSP: theSP
	| sender ip na spc sp |
	<api>
	<inline: false>
	self shortPrintContext: aContext.
	sender := self fetchPointer: SenderIndex ofObject: aContext.
	ip := self fetchPointer: InstructionPointerIndex ofObject: aContext.
	sp := self integerObjectOf: (self stackPointerIndexFor: theSP context: aContext) - ReceiverIndex.
	self print: 'sender   '; shortPrintOop: sender.
	self print: 'ip       '; printNum: ip; print: ' ('; printNum: (self integerValueOf: ip); space; printHex: (self integerValueOf: ip); printChar: $); cr.
	self print: 'sp       '; printNum: sp; print: ' ('; printNum: (self integerValueOf: sp); printChar: $); cr.
	(self isMethodContext: aContext)
		ifTrue:
			[self print: 'method   '; shortPrintOop: (self fetchPointer: MethodIndex ofObject: aContext).
			self print: 'closure  '; shortPrintOop: (self fetchPointer: ClosureIndex ofObject: aContext).
			self print: 'receiver '; shortPrintOop: (self fetchPointer: ReceiverIndex ofObject: aContext)]
		ifFalse:
			[na := self fetchPointer: BlockArgumentCountIndex ofObject: aContext.
			self print: 'numargs  '; printNum: na; print: ' ('; printNum: (self integerValueOf: na); printChar: $); cr.
			spc := self fetchPointer: InitialIPIndex ofObject: aContext.
			self print: 'startpc  '; printNum: spc; print: ' ('; printNum: (self integerValueOf: spc); printChar: $); cr.
			self print: 'home     '; shortPrintOop: (self fetchPointer: HomeIndex ofObject: aContext)].
	sp := self integerValueOf: sp.
	sp := sp min: (self lengthOf: aContext) - ReceiverIndex.
	1 to: sp do:
		[:i|
		self print: '       '; printNum: i; space; shortPrintOop: (self fetchPointer: ReceiverIndex + i ofObject: aContext)]