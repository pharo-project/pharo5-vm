oop functions
normalizePositive: aLargePositiveInteger 
	"Check for leading zeroes and return shortened copy if so."
	"First establish len = significant length."
	| sLen val len oldLen pointer |
	<var: #pointer type: #'unsigned char *'>
	len := oldLen := self digitLengthOfNonImmediate: aLargePositiveInteger.
	pointer := interpreterProxy
				cCoerce: (interpreterProxy firstIndexableField: aLargePositiveInteger)
				to: #'unsigned char *'.
	[len > 0 and: [(pointer at: len - 1) = 0]] whileTrue:
		[len := len - 1].
	len = 0 ifTrue: [^ 0 asOop: SmallInteger].

	"Now check if in SmallInteger range"
	sLen := interpreterProxy maxSmallInteger > 16r3FFFFFFF "SmallInteger maxVal digitLength."
				ifTrue: [8]
				ifFalse: [4].
	len <= sLen ifTrue: 
		[(len < sLen
		  or: [(pointer at: sLen - 1) <= (self cDigitOfCSI: interpreterProxy maxSmallInteger at: sLen)]) ifTrue: 
			["If so, return its SmallInt value"
			 val := pointer at: (len := len - 1).
			 len - 1 to: 0 by: -1 do:
				[:i | val := val * 256 + (pointer at: i)].
			^val asOop: SmallInteger]].
	"Return self, or a shortened copy"
	len < oldLen ifTrue: "^ self growto: len"
		[^self largeInt: aLargePositiveInteger growTo: len].
	^aLargePositiveInteger