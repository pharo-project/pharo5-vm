C core util
cDigitOfCSI: csi at: ix 
	"Answer the value of an indexable field in the receiver.              
	LargePositiveInteger uses bytes of base two number, and each is a       
	      'digit' base 256."
	"ST indexed!"
	^self
		cCode: [(csi < 0
					ifTrue: [0 - csi]
					ifFalse: [csi]) >> (ix - 1 * 8) bitAnd: 255]
		inSmalltalk: [csi digitAt: ix]