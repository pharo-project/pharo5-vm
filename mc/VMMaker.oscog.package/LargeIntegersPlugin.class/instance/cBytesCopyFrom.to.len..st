C core util
cBytesCopyFrom: pFrom to: pTo len: len 
	| limit |
	<returnTypeC: 'int'>
	<var: #pFrom type: 'unsigned char * '>
	<var: #pTo type: 'unsigned char * '>

	self cCode: '' inSmalltalk: [
		(interpreterProxy isKindOf: InterpreterSimulator) ifTrue: [
			"called from InterpreterSimulator"
				limit := len - 1.
				0 to: limit do: [:i |
					interpreterProxy byteAt: pTo + i
						put: (interpreterProxy byteAt: pFrom + i)
				].
			^ 0
		].
	].	
	limit := len - 1.
	0 to: limit do: [:i | pTo at: i put: (pFrom at: i)].
	^ 0