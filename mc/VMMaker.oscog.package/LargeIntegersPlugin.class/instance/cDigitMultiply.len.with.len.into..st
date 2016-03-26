C core
cDigitMultiply: pByteShort len: shortLen with: pByteLong len: longLen into: pByteRes 
	| limitLong digit k carry limitShort ab |
	<returnTypeC: #'unsigned char'>
	<var: #pByteShort type: #'unsigned char *'>
	<var: #pByteLong type: #'unsigned char *'>
	<var: #pByteRes type: #'unsigned char *'>
	<var: #digit type: #'unsigned int'>
	<var: #carry type: #'unsigned int'>
	<var: #ab type: #'unsigned int'>
	(shortLen = 1 and: [(pByteShort at: 0)
			= 0])
		ifTrue: [^ 0].
	(longLen = 1 and: [(pByteLong at: 0)
			= 0])
		ifTrue: [^ 0].
	"prod starts out all zero"
	limitShort := shortLen - 1.
	limitLong := longLen - 1.
	0 to: limitShort do: [:i | (digit := pByteShort at: i) ~= 0
			ifTrue: 
				[k := i.
				carry := 0.
				"Loop invariant: 0<=carry<=0377, k=i+j-1 (ST)"
				"-> Loop invariant: 0<=carry<=0377, k=i+j (C) (?)"
				0 to: limitLong do: 
					[:j | 
					ab := (pByteLong at: j).
					ab := ab * digit + carry + (pByteRes at: k).
					carry := ab >> 8.
					pByteRes at: k put: (ab bitAnd: 16rFF).
					k := k + 1].
				pByteRes at: k put: carry]].
	^ 0