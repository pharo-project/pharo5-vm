C core util
cDigitOfCSI: csi at: ix 
	"Answer the value of an indexable field in the receiver.              
	LargePositiveInteger uses bytes of base two number, and each is a       
	      'digit' base 256."
	"ST indexed!"
	ix < 1 ifTrue: [interpreterProxy primitiveFail].
	ix > 4 ifTrue: [^ 0].
	csi < 0
		ifTrue: 
			[self cCode: ''
				inSmalltalk: [csi = -1073741824 ifTrue: ["SmallInteger minVal"
						"Can't negate minVal -- treat specially"
						^ #(0 0 0 64 ) at: ix]].
			^ (0 - csi) >> (ix - 1 * 8)
				bitAnd: 255]
		ifFalse: [^ csi >> (ix - 1 * 8)
				bitAnd: 255]