image segment in/out
wordSwapFloatsFrom: startOop to: stopAddr
	"Swap the most and least significant words of Floats in a range of the image."
	| oop temp |
	oop := startOop.
	[self oop: oop isLessThan: stopAddr] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[((self formatOf: oop) = self firstLongFormat
			 and: [(self compactClassIndexOf: oop) = ClassFloatCompactIndex]) ifTrue:
				[temp := self longAt: oop + self baseHeaderSize.
				 self longAt: oop + self baseHeaderSize put: (self longAt: oop + self baseHeaderSize + 4).
				 self longAt: oop + self baseHeaderSize + 4 put: temp]].
		oop := self objectAfter: oop]