system control primitives
primitiveUtcWithOffset
	"Answer an array with UTC microseconds since the Posix epoch and the
	current seconds offset from GMT in the local time zone. An empty two
	element array (or any object with two or more slots) may be supplied
	as a parameter.
	This is a named (not numbered) primitive in the null module (ie the VM)"
	| epochDelta offset resultArray utcMicroseconds |

	<export: true>
	<var: #epochDelta declareC: 'static usqLong epochDelta= 2177452800000000ULL'>
	<var: #utcMicroseconds type: #usqLong>
	<var: #offset type: #sqLong>
	argumentCount > 1 ifTrue: [^self primitiveFailFor: PrimErrBadNumArgs].
	self cCode: '' inSmalltalk: [epochDelta := 2177452800000000].
	utcMicroseconds := self ioUTCMicroseconds.
	offset := self ioLocalMicroseconds - utcMicroseconds.
	offset := offset / 1000000.
	objectMemory pushRemappableOop: (self positive64BitIntegerFor: utcMicroseconds - epochDelta).
	argumentCount > 0
		ifTrue: [resultArray := self popStack.
			((objectMemory isPointers: resultArray)
				and: [(objectMemory lengthOf: resultArray) >= 2])
					ifFalse: [^self primitiveFailFor: PrimErrBadArgument]]
		ifFalse: [resultArray := objectMemory instantiateClass: objectMemory classArray indexableSize: 2].
	objectMemory storePointer: 0 ofObject: resultArray withValue: objectMemory popRemappableOop.
	objectMemory storePointerUnchecked: 1 ofObject: resultArray withValue: (objectMemory integerObjectOf: offset).
	self pop: 1 thenPush: resultArray
