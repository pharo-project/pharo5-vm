system control primitives
primitiveUtcWithOffset
	"Answer an array with UTC microseconds since the Posix epoch and
	the current seconds offset from GMT in the local time zone.
	This is a named (not numbered) primitive in the null module (ie the VM)"
	| resultArray |
	<export: true>
	"2177452800000000 = '1/1/1970' asDate asSeconds - '1/1/1901' asDate asSeconds * 1,000,000"
	objectMemory pushRemappableOop: (self positive64BitIntegerFor: self ioUTCMicroseconds - 2177452800000000).
	resultArray := objectMemory instantiateClass: objectMemory classArray indexableSize: 2.
	self storePointer: 0 ofObject: resultArray withValue: objectMemory popRemappableOop.
	self storePointerUnchecked: 1 ofObject: resultArray withValue: (objectMemory integerObjectOf: self ioLocalSecondsOffset).
	self pop: 1 thenPush: resultArray
