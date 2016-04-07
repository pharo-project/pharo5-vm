simulation
sqFile: file Write: count From: byteArrayIndexArg At: startIndex
	| interpreter byteArrayIndex |
	interpreter := interpreterProxy interpreter.
	byteArrayIndex := byteArrayIndexArg isInteger ifTrue: [byteArrayIndexArg] ifFalse: [byteArrayIndexArg cPtrAsOop].
	file isBinary
		ifTrue:
			[startIndex to: startIndex + count - 1 do:
				[ :i | file nextPut: (interpreter byteAt: byteArrayIndex + i)]]
		ifFalse:
			[startIndex to: startIndex + count - 1 do:
				[ :i | | byte |
				byte := interpreter byteAt: byteArrayIndex + i.
				file nextPut: (Character value: (byte == 12 "lf" ifTrue: [15"cr"] ifFalse: [byte]))]].
	self recordStateOf: file.
	^count