oop functions
isNormalized: anInteger 
	| len maxVal minVal sLen |
	(interpreterProxy isIntegerObject: anInteger)
		ifTrue: [^ true].
	"Check for leading zero of LargeInteger"
	len := self digitLength: anInteger.
	len = 0
		ifTrue: [^ false].
	(self unsafeByteOf: anInteger at: len)
			= 0
		ifTrue: [^ false].
	"no leading zero, now check if anInteger is in SmallInteger range or not"
	sLen := 4.
	"maximal digitLength of aSmallInteger"
	len > sLen
		ifTrue: [^ true].
	len < sLen
		ifTrue: [^ false].
	"len = sLen"
	(interpreterProxy fetchClassOf: anInteger)
			= interpreterProxy classLargePositiveInteger
		ifTrue: [maxVal := 1073741823. "SmallInteger maxVal"
				"all bytes of maxVal but the highest one are just FF's"
				^ (self unsafeByteOf: anInteger at: sLen)
					> (self cDigitOfCSI: maxVal at: sLen)]
		ifFalse: [minVal := -1073741824. "SmallInteger minVal"
				"all bytes of minVal but the highest one are just 00's"
			(self unsafeByteOf: anInteger at: sLen)
					< (self cDigitOfCSI: minVal at: sLen)
				ifTrue: [^ false]
				ifFalse: ["if just one digit differs, then anInteger < minval (the corresponding digit byte is greater!)
						and therefore a LargeNegativeInteger"
					1
						to: sLen
						do: [:ix | (self unsafeByteOf: anInteger at: ix)
									= (self cDigitOfCSI: minVal at: ix)
								ifFalse: [^ true]]]].
	^ false