debug printing
shortPrintOop: oop
	<inline: false>
	self printHex: oop.
	(objectMemory isImmediate: oop) ifTrue:
		[(objectMemory isImmediateCharacter: oop) ifTrue:
			[^self
				cCode: 'printf("=$%ld ($%c)\n", (long)characterValueOf(oop), (long)characterValueOf(oop))'
				inSmalltalk: [self print: (self shortPrint: oop); cr]].
		 ^self
			cCode: 'printf("=%ld\n", (long)integerValueOf(oop))'
			inSmalltalk: [self print: (self shortPrint: oop); cr]].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[self print: ((oop bitAnd: objectMemory allocationUnit - 1) ~= 0
						ifTrue: [' is misaligned']
						ifFalse: [' is not on the heap']); cr.
		 ^nil].
	((objectMemory isFreeObject: oop)
	 or: [objectMemory isForwarded: oop]) ifTrue:
		[^self printOop: oop].
	self print: ': a(n) '.
	self printNameOfClass: (objectMemory fetchClassOfNonImm: oop) count: 5.
	self cr