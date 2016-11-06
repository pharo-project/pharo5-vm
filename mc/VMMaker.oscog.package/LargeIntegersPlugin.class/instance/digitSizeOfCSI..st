util
digitSizeOfCSI: csi 
	"Answer the number of 32-bits fields of a C-SmallInteger. This value is 
	   the same as the largest legal subscript."
	^(interpreterProxy maxSmallInteger <= 16r3FFFFFFF)
		ifTrue: [1]
		ifFalse: [csi > 16rFFFFFFFF asIntegerPtr "conversion is not really needed here, but avoid generating a warning in 32bits, and harmless in 64bits"
			ifTrue: [2]
			ifFalse: [csi < -16rFFFFFFFF
				ifTrue: [2]
				ifFalse: [1]]]