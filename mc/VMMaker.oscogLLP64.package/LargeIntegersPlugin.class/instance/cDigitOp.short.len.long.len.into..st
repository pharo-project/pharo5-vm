C core
cDigitOp: opIndex short: pWordShort len: shortLen long: pWordLong len: longLen into: pWordRes 
	"pWordRes len = longLen.
	NOTE: we don't bother with endianness here, those bit opes are endian-neutral"
	| limit |
	<var: #pWordShort type: #'unsigned int *'>
	<var: #pWordLong type: #'unsigned int *'>
	<var: #pWordRes type: #'unsigned int *'>
	limit := shortLen - 1.
	opIndex = andOpIndex
		ifTrue: 
			[0 to: limit do: [:i | pWordRes at: i put: ((pWordShort at: i)
						bitAnd: (pWordLong at: i))].
			limit := longLen - 1.
			shortLen to: limit do: [:i | pWordRes at: i put: 0].
			^ 0].
	opIndex = orOpIndex
		ifTrue: 
			[0 to: limit do: [:i | pWordRes at: i put: ((pWordShort at: i)
						bitOr: (pWordLong at: i))].
			limit := longLen - 1.
			shortLen to: limit do: [:i | pWordRes at: i put: (pWordLong at: i)].
			^ 0].
	opIndex = xorOpIndex
		ifTrue: 
			[0 to: limit do: [:i | pWordRes at: i put: ((pWordShort at: i)
						bitXor: (pWordLong at: i))].
			limit := longLen - 1.
			shortLen to: limit do: [:i | pWordRes at: i put: (pWordLong at: i)].
			^ 0].
	^ interpreterProxy primitiveFail