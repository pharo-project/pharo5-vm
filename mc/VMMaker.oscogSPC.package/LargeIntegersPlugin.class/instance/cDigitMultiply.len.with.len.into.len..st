C core
cDigitMultiply: pWordShort len: shortLen with: pWordLong len: longLen into: pWordRes len: resLen
	| limitLong digit k carry limitShort ab |
	<returnTypeC: #'unsigned int'>
	<var: #pWordShort type: #'unsigned int *'>
	<var: #pWordLong type: #'unsigned int *'>
	<var: #pWordRes type: #'unsigned int *'>
	<var: #digit type: #'unsigned int'>
	<var: #carry type: #'unsigned int'>
	<var: #ab type: #'unsigned long long'>
	(shortLen = 1 and: [(pWordShort at: 0) = 0])
		ifTrue: [^ 0].
	(longLen = 1 and: [(pWordLong at: 0) = 0])
		ifTrue: [^ 0].
	"prod starts out all zero"
	limitShort := shortLen - 1.
	limitLong := longLen - 1.
	0 to: limitShort do: [:i | (digit := self cDigitOf: pWordShort at: i) ~= 0
			ifTrue: 
				[k := i.
				carry := 0.
				"Loop invariant: 0<=carry<=16rFFFFFFFF, k=i+j-1 (ST)"
				"-> Loop invariant: 0<=carry<=16rFFFFFFFF, k=i+j (C) (?)"
				0 to: limitLong do: 
					[:j | 
					ab := (self cDigitOf: pWordLong at: j).
					ab := ab * digit + carry + (self cDigitOf: pWordRes at: k).
					carry := ab >> 32.
					self cDigitOf: pWordRes at: k put: (ab bitAnd: 16rFFFFFFFF).
					k := k + 1].
				k < resLen ifTrue: [self cDigitOf: pWordRes at: k put: carry]]].
	^ 0