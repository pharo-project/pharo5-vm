oop functions
isNormalized: anInteger 
	| len maxVal minVal sLen val class positive |
	<var: #val type: #'unsigned long'>
	<var: #minVal type: #'unsigned long'>
	(interpreterProxy isIntegerObject: anInteger)
		ifTrue: [^ true].
	class := interpreterProxy fetchClassOf: anInteger.
	(positive := class = interpreterProxy classLargePositiveInteger) ifFalse:
		[class = interpreterProxy classLargeNegativeInteger ifFalse:
			[interpreterProxy primitiveFailFor: PrimErrBadArgument.
			 ^false]].
	"Check for leading zero of LargeInteger"
	len := self byteSizeOfLargeInt: anInteger.
	len = 0 ifTrue:
		[^ false].
	(self unsafeByteOfLargeInt: anInteger at: len) = 0 ifTrue:
		[^ false].
	"no leading zero, now check if anInteger is in SmallInteger range or not"
	sLen := interpreterProxy maxSmallInteger > 16r3FFFFFFF
				ifTrue: [8]
				ifFalse: [4].
	"maximal digitLength of aSmallInteger"
	len > sLen ifTrue:
		[^ true].
	len < sLen ifTrue:
		[^ false].
	"len = sLen"
	^positive
		ifTrue: [maxVal := interpreterProxy maxSmallInteger. "SmallInteger maxVal"
				"all bytes of maxVal but the highest one are just FF's"
				 (self digitOfCSI: anInteger at: sLen // 4)
					> (self digitOfCSI: maxVal at: sLen // 4)]
		ifFalse: [val := self unsafeDigitOfLargeInt: anInteger at: len // 4.
				sLen > 4 ifTrue: [val := val << 32 + (self unsafeDigitOfLargeInt: anInteger at: 1)].
				minVal := 0 - interpreterProxy minSmallInteger.
				val > minVal]