bootstrap methods
oldFormatHeaderFor: method
	| primBits primitive |
	primitive := method primitive.
	primBits := primitive <= 16r1FF
					ifTrue: [primitive]
					ifFalse: [(primitive bitAnd: 16r1FF) + ((primitive bitAnd: 16r200) bitShift: 19)].
	^(method numArgs bitShift: 24)
	+ (method numTemps bitShift: 18)
	+ (method frameSize > method class smallFrameSize ifTrue: [1 << 17] ifFalse: [0])
	+ (method numLiterals bitShift: 9)
	+ primBits