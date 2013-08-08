C core
cByteOp: opIndex short: pByteShort len: shortLen long: pByteLong len: longLen into: pByteRes 
	"pByteRes len = longLen."
	| limit |
	<var: #pByteShort type: 'unsigned char * '>
	<var: #pByteLong type: 'unsigned char * '>
	<var: #pByteRes type: 'unsigned char * '>
	limit := shortLen - 1.
	opIndex = andOpIndex
		ifTrue: 
			[0 to: limit do: [:i | pByteRes at: i put: ((pByteShort at: i)
						bitAnd: (pByteLong at: i))].
			limit := longLen - 1.
			shortLen to: limit do: [:i | pByteRes at: i put: 0].
			^ 0].
	opIndex = orOpIndex
		ifTrue: 
			[0 to: limit do: [:i | pByteRes at: i put: ((pByteShort at: i)
						bitOr: (pByteLong at: i))].
			limit := longLen - 1.
			shortLen to: limit do: [:i | pByteRes at: i put: (pByteLong at: i)].
			^ 0].
	opIndex = xorOpIndex
		ifTrue: 
			[0 to: limit do: [:i | pByteRes at: i put: ((pByteShort at: i)
						bitXor: (pByteLong at: i))].
			limit := longLen - 1.
			shortLen to: limit do: [:i | pByteRes at: i put: (pByteLong at: i)].
			^ 0].
	^ interpreterProxy primitiveFail