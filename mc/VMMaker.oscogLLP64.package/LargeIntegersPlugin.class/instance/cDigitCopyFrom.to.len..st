C core util
cDigitCopyFrom: pFrom to: pTo len: len 
	<var: #pFrom type: #'unsigned int *'>
	<var: #pTo type: #'unsigned int *'>

	self cCode: '' inSmalltalk: [
		(interpreterProxy isKindOf: InterpreterSimulator) ifTrue: [
			"called from InterpreterSimulator"
				0 to: (len - 1) * 4 do: [:i |
					interpreterProxy byteAt: pTo + i
						put: (interpreterProxy byteAt: pFrom + i)
				].
			^ 0
		].
	].	
	"Note: don't care about endianness here, copy operation is endian neutral"
	0 to: len - 1 do: [:i | pTo at: i put: (pFrom at: i)].
	^ 0