system control primitives
primitiveUtcWithOffset
	"Answer an array with UTC microseconds since the Posix epoch and
	the current seconds offset from GMT in the local time zone.
	This is a named (not numbered) primitive in the null module (ie the VM)"
	| epochDelta offset resultArray utcMicroseconds |

	<export: true>
	<var: #epochDelta declareC: 'static usqLong epochDelta= 2177452800000000ULL'>
	<var: #utcMicroseconds type: #usqLong>
	<var: #offset type: #sqLong>
	utcMicroseconds := self ioUTCMicroseconds.
	offset := self ioLocalMicroseconds - utcMicroseconds.
	offset := offset / 1000000.
	objectMemory pushRemappableOop: (self positive64BitIntegerFor: utcMicroseconds - epochDelta).
	resultArray := objectMemory instantiateClass: objectMemory classArray indexableSize: 2.
	self storePointer: 0 ofObject: resultArray withValue: objectMemory popRemappableOop.
	self storePointerUnchecked: 1 ofObject: resultArray withValue: (objectMemory integerObjectOf: offset).
	self pop: 1 thenPush: resultArray
