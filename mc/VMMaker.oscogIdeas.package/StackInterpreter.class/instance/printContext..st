debug printing
printContext: aContext
	| sender ip sp |
	<inline: false>
	self shortPrintContext: aContext.
	sender := objectMemory fetchPointer: SenderIndex ofObject: aContext.
	ip := objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext.
	(objectMemory isIntegerObject: sender)
		ifTrue:
			[(self checkIsStillMarriedContext: aContext currentFP: framePointer)
				ifTrue: [self print: 'married (assuming framePointer valid)'; cr]
				ifFalse: [self print: 'widowed (assuming framePointer valid)'; cr].
			self print: 'sender   '; printNum: sender; print: ' (';
				printHexPtr: (self withoutSmallIntegerTags: sender); printChar: $); cr.
			 self print: 'ip       '; printNum: ip; print: ' (';
				printHexPtr: (self withoutSmallIntegerTags: ip); printChar: $); cr]
		ifFalse:
			[self print: 'sender   '; shortPrintOop: sender.
			 self print: 'ip       '.
			 ip = objectMemory nilObject
				ifTrue: [self shortPrintOop: ip]
				ifFalse: [self printNum: ip; print: ' ('; printNum: (objectMemory integerValueOf: ip); space; printHex: (objectMemory integerValueOf: ip); printChar: $); cr]].
	sp := objectMemory fetchPointer: StackPointerIndex ofObject: aContext.
	sp := sp min: (objectMemory lengthOf: aContext) - ReceiverIndex.
	self print: 'sp       '; printNum: sp; print: ' ('; printNum: (objectMemory integerValueOf: sp); printChar: $); cr.
	self print: 'method   '; printMethodFieldForPrintContext: aContext.
	self print: 'closure  '; shortPrintOop: (objectMemory fetchPointer: ClosureIndex ofObject: aContext).
	self print: 'receiver '; shortPrintOop: (objectMemory fetchPointer: ReceiverIndex ofObject: aContext).
	sp := objectMemory integerValueOf: sp.
	1 to: sp do:
		[:i|
		self print: '       '; printNum: i; space; shortPrintOop: (objectMemory fetchPointer: ReceiverIndex + i ofObject: aContext)]