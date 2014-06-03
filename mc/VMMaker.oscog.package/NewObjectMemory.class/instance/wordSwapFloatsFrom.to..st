image segment in/out
wordSwapFloatsFrom: startOop to: stopAddr
	"Swap the most and least significant words of Floats in a range of the image."
	| oop temp |
	oop := startOop.
	[self oop: oop isLessThan: stopAddr] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[((self formatOf: oop) = self firstLongFormat
			 and: [(self compactClassIndexOf: oop) = ClassFloatCompactIndex]) ifTrue:
				[temp := self longAt: oop + BaseHeaderSize.
				 self longAt: oop + BaseHeaderSize put: (self longAt: oop + BaseHeaderSize + 4).
				 self longAt: oop + BaseHeaderSize + 4 put: temp]].
		oop := self objectAfter: oop]