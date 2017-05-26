system control primitives
primitiveUTCMicrosecondClock
	"Return the value of the microsecond clock in UTC as an integer.
	 This is the number of microseconds since the Smalltalk epoch, 1901/1/1 12:00am.
	 The microsecond clock is at least 60 bits wide which means it'll get to around August
	 38435 before it wraps around.  Be sure to put it on your calendar.  This primitive
	 accesses the time as answered by the OS."

	self pop: 1 thenPush: (self positive64BitIntegerFor: self ioUTCMicrosecondsNow)