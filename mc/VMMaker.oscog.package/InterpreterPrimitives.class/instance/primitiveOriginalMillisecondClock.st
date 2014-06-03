system control primitives
primitiveOriginalMillisecondClock
	"Return the value of the millisecond clock as an integer, using the old method prior to the 64-bit microsecond clock."
	<export: true>
	self pop: 1 thenPush: (objectMemory integerObjectOf: (self ioOldMSecs bitAnd: MillisecondClockMask))