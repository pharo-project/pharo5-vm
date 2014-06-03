accessing
temporaryCountOfMethodHeader: header
	^(CompiledMethod
			newMethod: 8
			header: (header <= SmallInteger maxVal
						ifTrue: [header]
						ifFalse: [(header bitAnd: SmallInteger maxVal) + SmallInteger minVal]))
		numTemps