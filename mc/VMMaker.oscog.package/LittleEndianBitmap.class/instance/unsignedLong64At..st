accessing
unsignedLong64At: byteAddress
	"memory is a Bitmap, a 32-bit indexable array of bits"
	| lowBits hiWord loWord midWord mask wordIndex result |
	wordIndex := byteAddress - 1 // 4 + 1.
	(lowBits := byteAddress - 1 \\ 4) = 0 ifTrue:
		[loWord := self at: wordIndex.
		 hiWord := self at: wordIndex + 1.
		 ^hiWord = 0
			ifTrue: [loWord]
			ifFalse: [(hiWord bitShift: 32) + loWord]].
	"There will always be three accesses; two partial words and a full word in the middle"
	mask := 16rFFFFFFFF bitShift: 4 - lowBits * -8.
	loWord := (self at: wordIndex) bitAnd: mask bitInvert32.
	midWord := self at: wordIndex + 1.
	hiWord := (self at: wordIndex + 2) bitAnd: mask.
	result := loWord bitShift: lowBits * -8.
	midWord ~= 0 ifTrue:
		[result := result + (midWord bitShift: (4 - lowBits * 8))].
	hiWord ~= 0 ifTrue:
		[result := result + (hiWord bitShift: (4 - lowBits + 4 * 8))].
	^result