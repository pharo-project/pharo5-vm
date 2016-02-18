oop functions
normalizeNegative: aLargeNegativeInteger 
	"Check for leading zeroes and return shortened copy if so."
	"First establish len = significant length."
	| sLen val len oldLen pointer |
	len := oldLen := self digitLengthOfNonImmediate: aLargeNegativeInteger.
	pointer := interpreterProxy
				cCoerce: (interpreterProxy firstIndexableField: aLargeNegativeInteger)
				to: #'unsigned char *'.
	[len > 0 and: [(pointer at: len - 1) = 0]] whileTrue:
		[len := len - 1].
	len = 0 ifTrue: [^ 0 asOop: SmallInteger].

	"Now check if in SmallInteger range"
	sLen := interpreterProxy minSmallInteger < -16r40000000
				ifTrue: [8]
				ifFalse: [4]. "SmallInteger digitLength"
	len <= sLen ifTrue: 
		[(len < sLen
		  or: [(pointer at: sLen - 1)
				< (self cDigitOfCSI: interpreterProxy minSmallInteger at: sLen)]) ifTrue: "interpreterProxy minSmallInteger lastDigit"
			["If high digit less, then can be small"
			val := 0 - (pointer at: (len := len - 1)).
			len - 1 to: 0 by: -1 do:
				[:i | val := val * 256 - (pointer at: i)].
			^val asOop: SmallInteger].
		 1 to: sLen do:
			[:i | | byte | "If all digits same, then = minSmallInteger (sr: minSmallInteger digits 1 to sLen - 1 are 0)"
			byte := i > len ifTrue: [0] ifFalse: [pointer at: i - 1].
			byte ~= (self cDigitOfCSI: interpreterProxy minSmallInteger at: i) ifTrue: "Not so; return self shortened"
				[len < oldLen ifTrue: "^ self growto: len"
					[^self bytes: aLargeNegativeInteger growTo: len].
				 ^aLargeNegativeInteger]].
		 ^interpreterProxy minSmallInteger asOop: SmallInteger].
	"Return self, or a shortened copy"
	len < oldLen ifTrue: "^ self growto: len"
		[^self bytes: aLargeNegativeInteger growTo: len].
	^aLargeNegativeInteger