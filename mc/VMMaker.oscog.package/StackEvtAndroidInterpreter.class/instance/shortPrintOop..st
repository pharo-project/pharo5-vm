debug printing
shortPrintOop: oop
	<inline: false>
	self printNum: oop.
	(objectMemory isIntegerObject: oop) ifTrue:
		[^self cCode: 'jprintf("=%ld\n", integerValueOf(oop))' inSmalltalk: [self print: (self shortPrint: oop); cr]].
	(oop between: objectMemory startOfMemory and: objectMemory freeStart) ifFalse:
		[self printHex: oop; print: ' is not on the heap'; cr.
		 ^nil].
	(oop bitAnd: (BytesPerWord - 1)) ~= 0 ifTrue:
		[self printHex: oop; print: ' is misaligned'; cr.
		 ^nil].
	self print: ': a(n) '.
	self printNameOfClass: (objectMemory fetchClassOf: oop) count: 5.
	self cr