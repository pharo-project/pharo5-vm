oop functions
normalizeNegative: aLargeNegativeInteger 
	"Check for leading zeroes and return shortened copy if so."
	"First establish len = significant length."
	| sLen val len oldLen minVal |
	len := oldLen := self digitLength: aLargeNegativeInteger.
	[len ~= 0 and: [(self unsafeByteOf: aLargeNegativeInteger at: len)
			= 0]]
		whileTrue: [len := len - 1].
	len = 0 ifTrue: [^ 0 asOop: SmallInteger].
	"Now check if in SmallInteger range"
	sLen := 4.
	"SmallInteger minVal digitLength"
	len <= sLen
		ifTrue: 
			["SmallInteger minVal"
			minVal := -1073741824.
			(len < sLen or: [(self digitOfBytes: aLargeNegativeInteger at: sLen)
					< (self cDigitOfCSI: minVal at: sLen)
				"minVal lastDigit"])
				ifTrue: 
					["If high digit less, then can be small"
					val := 0.
					len
						to: 1
						by: -1
						do: [:i | val := val * 256 - (self unsafeByteOf: aLargeNegativeInteger at: i)].
					^ val asOop: SmallInteger].
			1 to: sLen do: [:i | "If all digits same, then = minVal (sr: minVal digits 1 to 3 are 
				          0)"
				(self digitOfBytes: aLargeNegativeInteger at: i)
					= (self cDigitOfCSI: minVal at: i)
					ifFalse: ["Not so; return self shortened"
						len < oldLen
							ifTrue: ["^ self growto: len"
								^ self bytes: aLargeNegativeInteger growTo: len]
							ifFalse: [^ aLargeNegativeInteger]]].
			^ minVal asOop: SmallInteger].
	"Return self, or a shortened copy"
	len < oldLen
		ifTrue: ["^ self growto: len"
			^ self bytes: aLargeNegativeInteger growTo: len]
		ifFalse: [^ aLargeNegativeInteger]