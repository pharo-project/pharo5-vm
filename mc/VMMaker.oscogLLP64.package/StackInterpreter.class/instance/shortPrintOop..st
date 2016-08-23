debug printing
shortPrintOop: oop
	<inline: false>
	self printHexnp: oop.
	(objectMemory isImmediate: oop) ifTrue:
		[(objectMemory isIntegerObject: oop) ifTrue:
			[self
				cCode: 'printf("=%ld\n", (long)integerValueOf(oop))'
				inSmalltalk: [self print: (self shortPrint: oop); cr]].
		 (objectMemory isImmediateCharacter: oop) ifTrue:
			[self
				cCode: 'printf("=$%ld ($%lc)\n", (long)characterValueOf(oop), (wint_t)characterValueOf(oop))'
				inSmalltalk: [self print: (self shortPrint: oop); cr]].
		 (objectMemory isImmediateFloat: oop) ifTrue:
			[self
				cCode: 'printf("=%g\n", floatValueOf(oop))'
				inSmalltalk: [self print: '='; printFloat: (objectMemory floatValueOf: oop); cr]].
		 ^self].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^self print: ((oop bitAnd: objectMemory allocationUnit - 1) ~= 0
						ifTrue: [' is misaligned']
						ifFalse: [self whereIs: oop]); cr].
	((objectMemory isFreeObject: oop)
	 or: [objectMemory isForwarded: oop]) ifTrue:
		[^self printOop: oop].
	self print: ': a(n) '.
	self printNameOfClass: (objectMemory fetchClassOfNonImm: oop) count: 5.
	self cr