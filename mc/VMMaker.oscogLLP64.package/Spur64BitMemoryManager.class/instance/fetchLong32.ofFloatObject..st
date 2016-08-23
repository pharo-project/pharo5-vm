object access
fetchLong32: fieldIndex ofFloatObject: oop
	"index by word size, and return a pointer as long as the word size"
	
	| bits |
	(self isImmediateFloat: oop) ifFalse:
		[^self fetchLong32: fieldIndex ofObject: oop].
	bits := self smallFloatBitsOf: oop.
	^self
		cCode: [(self cCoerceSimple: (self addressOf: bits) to: #'int *') at: fieldIndex]
		inSmalltalk:
			[self flag: #endian.
			 fieldIndex = 0
				ifTrue: [bits bitAnd: 16rFFFFFFFF]
				ifFalse: [bits >> 32]]