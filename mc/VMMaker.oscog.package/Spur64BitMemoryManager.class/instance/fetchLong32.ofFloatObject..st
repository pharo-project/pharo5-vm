object access
fetchLong32: fieldIndex ofFloatObject: oop
	"index by word size, and return a pointer as long as the word size"
	
	| bits |
	(self isImmediateFloat: oop) ifFalse:
		[^self fetchLong32: fieldIndex ofObject: oop].
	bits := self smallFloatBitsOf: oop.
	^self
		cCode: [self longAt: (self cCoerceSimple: (self addressOf: bits) to: #'char *')
							+ (fieldIndex << self shiftForWord)]
		inSmalltalk: [self flag: #endian.
					fieldIndex = 0
						ifTrue: [bits >> 32]
						ifFalse: [bits bitAnd: 16rFFFFFFFF]]