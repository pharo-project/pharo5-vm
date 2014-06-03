system control primitives
primitiveLocalMicrosecondClock
	"Answer the local microseconds since the Smalltalk epoch. The value is
	derived from the Posix epoch with a constant offset corresponding to
	elapsed microseconds between the two epochs according to RFC 868,
	and with an offset duration corresponding to the current offset of local
	time from UTC."
	
	| clock offset offsetMillis epochDelta uSecs |

	<export: true>
	<var: #clock type: 'usqLong'>
	<var: #offset type: 'int'>
	<var: #offsetMillis type: 'usqLong'>
	<var: #epochDelta declareC: 'static usqLong epochDelta= 2177452800000000ULL'>
	(self cCode: 'ioUtcWithOffset(&clock, &offset)' inSmalltalk: [-1]) = -1
		ifTrue: [^ self primitiveFail].
	clock := clock + epochDelta. "adjust for nominal Smalltalk epoch"
	offsetMillis := offset.
	offsetMillis := offsetMillis * 1000000.
	clock := clock + offsetMillis. "adjust for local time offset"
	uSecs := self positive64BitIntegerFor: clock.
	self pop: 1 thenPush: uSecs.
