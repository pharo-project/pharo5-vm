primitive support
microsecondsToMilliseconds: microseconds
	<var: #microseconds type: #usqLong>
	^microseconds // 1000 bitAnd: MillisecondClockMask