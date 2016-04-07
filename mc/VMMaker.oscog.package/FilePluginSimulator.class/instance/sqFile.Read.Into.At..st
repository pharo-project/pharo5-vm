simulation
sqFile: file Read: count Into: byteArrayIndexArg At: startIndex
	| interpreter byteArrayIndex |
	interpreter := interpreterProxy interpreter.
	byteArrayIndex := byteArrayIndexArg isInteger ifTrue: [byteArrayIndexArg] ifFalse: [byteArrayIndexArg cPtrAsOop].
	[[startIndex to: startIndex + count - 1 do:
		[ :i |
		file atEnd ifTrue:
			[(file isKindOf: FakeStdinStream) ifTrue: [file atEnd: false].
			 ^i - startIndex].
		interpreter
			byteAt: byteArrayIndex + i
			put: file next asInteger]]
			on: Error
			do: [:ex|
				(file isKindOf: TranscriptStream) ifFalse: [ex pass].
				^0]]
		ensure: [self recordStateOf: file].
	^count