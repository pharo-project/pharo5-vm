callout support
ffiCreateLongLongReturn: isSigned
	"Create a longlong return value from a previous call out"
	| lowWord highWord largeClass nBytes largeInt ptr |
	<var: #ptr type:'unsigned char *'>
	lowWord := self ffiLongLongResultLow.
	highWord := self ffiLongLongResultHigh.
	isSigned ifTrue:["check for 32 bit signed"
		(highWord = 0 and:[lowWord >= 0])
			ifTrue:[^interpreterProxy signed32BitIntegerFor: lowWord].
		(highWord = -1 and:[lowWord < 0])
			ifTrue:[^interpreterProxy signed32BitIntegerFor: lowWord].
		"negate value for negative longlong"
		highWord < 0 
			ifTrue:[	largeClass := interpreterProxy classLargeNegativeInteger.
					lowWord := lowWord bitInvert32.
					highWord := highWord bitInvert32.
					lowWord = -1 "e.g., overflow when adding one"
						ifTrue:[highWord := highWord + 1].
					lowWord := lowWord + 1]
			ifFalse:[largeClass := interpreterProxy classLargePositiveInteger].
			"fall through"
	] ifFalse:["check for 32 bit unsigned"
		highWord = 0 ifTrue:[
			^interpreterProxy positive32BitIntegerFor: lowWord].
		largeClass := interpreterProxy classLargePositiveInteger.
		"fall through"
	].
	"Create LargeInteger result"
	nBytes := 8.
	(highWord anyMask: 255 << 24) ifFalse:[
		nBytes := 7.
		highWord < (1 << 16) ifTrue:[nBytes := 6].
		highWord < (1 << 8) ifTrue:[nBytes := 5].
		highWord = 0 ifTrue:[nBytes := 4]].
	"now we know how many bytes to create"
	largeInt := interpreterProxy instantiateClass: largeClass indexableSize: nBytes.
	(interpreterProxy isBytes: largeInt) 
		ifFalse:[^self ffiFail: FFIErrorBadReturn]. "Hossa!"
	ptr := interpreterProxy firstIndexableField: largeInt.
	4 to: nBytes-1 do:[:i|
		ptr at: i put: (highWord >> (i-4*8) bitAnd: 255)].
	ptr at: 3 put: (lowWord >> 24 bitAnd: 255).
	ptr at: 2 put: (lowWord >> 16 bitAnd: 255).
	ptr at: 1 put: (lowWord >> 8 bitAnd: 255).
	ptr at: 0 put: (lowWord bitAnd: 255).
	^largeInt