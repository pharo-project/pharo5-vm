object access
fetchLong32: fieldIndex ofFloatObject: oop
	"index by word size, and return a pointer as long as the word size"
	
	| rot |
	(self isImmediateFloat: oop) ifFalse:
		[^self fetchLong32: fieldIndex ofObject: oop].
	
	rot := oop >> self numTagBits.
	rot > 1 ifTrue:
		[rot := rot + (self smallFloatExponentOffset << (self smallFloatMantissaBits + 1))].
	rot := self rotateRight: rot.
	^self
		cCode: [self longAt: (self cCoerceSimple: (self addressOf: rot) to: #'char *')
							+ (fieldIndex << self shiftForWord)]
		inSmalltalk: [self flag: #endian.
					fieldIndex = 0
						ifTrue: [rot >> 32]
						ifFalse: [rot bitAnd: 16rFFFFFFFF]]