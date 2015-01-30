oop functions
normalizePositive: aLargePositiveInteger 
	"Check for leading zeroes and return shortened copy if so."
	"First establish len = significant length."
	| sLen val len oldLen |
	len := oldLen := self digitLength: aLargePositiveInteger.
	[len ~= 0 and: [(self unsafeByteOf: aLargePositiveInteger at: len)
			= 0]]
		whileTrue: [len := len - 1].
	len = 0 ifTrue: [^ 0 asOop: SmallInteger].
	"Now check if in SmallInteger range"
	sLen := interpreterProxy minSmallInteger > 16r3FFFFFFF "SmallInteger maxVal digitLength."
				ifTrue: [8]
				ifFalse: [4].
	(len <= sLen
	 and: [(self digitOfBytes: aLargePositiveInteger at: sLen)
			<= (self cDigitOfCSI: interpreterProxy maxSmallInteger at: sLen)
		"SmallInteger maxVal"])
		ifTrue: 
			["If so, return its SmallInt value"
			val := 0.
			len
				to: 1
				by: -1
				do: [:i | val := val * 256 + (self unsafeByteOf: aLargePositiveInteger at: i)].
			^ val asOop: SmallInteger].
	"Return self, or a shortened copy"
	len < oldLen
		ifTrue: ["^ self growto: len"
			^ self bytes: aLargePositiveInteger growTo: len]
		ifFalse: [^ aLargePositiveInteger]