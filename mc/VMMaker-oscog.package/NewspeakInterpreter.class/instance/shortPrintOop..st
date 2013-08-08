debug printing
shortPrintOop: oop
	<inline: false>
	self printHex: oop.
	(self isIntegerObject: oop) ifTrue:
		[^self cCode: 'printf("=%ld\n", (long)integerValueOf(oop))' inSmalltalk: [self print: (self shortPrint: oop); cr]].
	(oop between: self startOfMemory and: freeBlock) ifFalse:
		[self printHex: oop; print: ' is not on the heap'; cr.
		 ^nil].
	(oop bitAnd: (BytesPerWord - 1)) ~= 0 ifTrue:
		[self printHex: oop; print: ' is misaligned'; cr.
		 ^nil].
	self print: ': a(n) '.
	self printNameOfClass: (self fetchClassOf: oop) count: 5.
	self cr