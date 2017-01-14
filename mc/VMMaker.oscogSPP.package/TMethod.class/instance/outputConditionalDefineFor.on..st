C code generation
outputConditionalDefineFor: compileTimeOptionPragmas on: aStream
	aStream nextPutAll: '#if '.
	compileTimeOptionPragmas
		do: [:pragma|
			pragma keyword = #notOption: ifTrue:
				[aStream nextPut: $!].
			aStream nextPutAll: (pragma argumentAt: 1)]
		separatedBy: [aStream nextPutAll: ' && '].
	 aStream cr