system control primitives
primitiveLocalMicrosecondClock
	"Return the value of the microsecond clock as an integer.  The microsecond clock is at
	 least 60 bits wide which means it'll get to around August 38435 before it wraps around."

	self pop: 1 thenPush: (self positive64BitIntegerFor: self ioLocalMicrosecondsNow)