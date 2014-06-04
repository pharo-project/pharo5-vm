simulation
sqFile: file Read: count Into: byteArrayIndex At: startIndex
	| interpreter |
	interpreter := interpreterProxy interpreter.
	[[startIndex to: startIndex + count - 1 do:
		[ :i |
		file atEnd ifTrue: [^i - startIndex].
		interpreter
			byteAt: byteArrayIndex + i
			put: file next asInteger]]
			on: Error
			do: [:ex|
				(file isKindOf: TranscriptStream) ifFalse: [ex pass].
				^0]]
		ensure: [self recordStateOf: file].
	^count