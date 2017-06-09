simulation
sqFile: file Write: count From: byteArrayIndexArg At: startIndex
	| byteArrayIndex |
	byteArrayIndex := byteArrayIndexArg asInteger. "Coerces CArray et al correctly"
	file isBinary
		ifTrue:
			[startIndex to: startIndex + count - 1 do:
				[ :i | file nextPut: (interpreterProxy byteAt: byteArrayIndex + i)]]
		ifFalse:
			[startIndex to: startIndex + count - 1 do:
				[ :i | | byte |
				byte := interpreterProxy byteAt: byteArrayIndex + i.
				file nextPut: (Character value: (byte == 12 "lf" ifTrue: [15"cr"] ifFalse: [byte]))]].
	self recordStateOf: file.
	^count