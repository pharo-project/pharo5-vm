util
digitOfCSI: csi at: ix 
	"Answer the value of a 32 bits digit in a C-SmallInteger."
	"ST indexed!"
	^(csi < 0
		ifTrue:  [0 - csi]
		ifFalse: [csi]) >> (ix - 1 * 32)