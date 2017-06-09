simulation
sqFile: file Read: count Into: byteArrayIndexArg At: startIndex
	| byteArrayIndex |
	byteArrayIndex := byteArrayIndexArg asInteger. "Coerces CArray et al correctly"
	[[startIndex to: startIndex + count - 1 do:
		[ :i |
		file atEnd ifTrue:
			[(file isKindOf: FakeStdinStream) ifTrue: [file atEnd: false].
			 ^i - startIndex].
		interpreterProxy
			byteAt: byteArrayIndex + i
			put: (file next ifNil: [(file isKindOf: FakeStdinStream) ifTrue: [^0]] ifNotNil: [:c| c asInteger])]]
			on: Error
			do: [:ex|
				(file isKindOf: TranscriptStream) ifFalse: [ex pass].
				^0]]
		ensure: [self recordStateOf: file].
	^count