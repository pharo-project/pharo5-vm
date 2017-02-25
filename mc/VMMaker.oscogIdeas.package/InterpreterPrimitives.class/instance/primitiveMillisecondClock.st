system control primitives
primitiveMillisecondClock
	"Return the value of the millisecond clock as an integer. Note that the millisecond clock wraps around periodically. On some platforms it can wrap daily. The range is limited to SmallInteger maxVal / 2 to allow delays of up to that length without overflowing a SmallInteger."

	self pop: 1 thenPush: (objectMemory integerObjectOf: (self ioMSecs bitAnd: MillisecondClockMask)).
