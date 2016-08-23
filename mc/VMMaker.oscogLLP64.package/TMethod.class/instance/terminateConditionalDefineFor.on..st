C code generation
terminateConditionalDefineFor: compileTimeOptionPragmas on: aStream
	compileTimeOptionPragmas ifEmpty: [^self].
	aStream nextPutAll: '#endif /* '.
	compileTimeOptionPragmas
		do: [:pragma|
			pragma keyword = #notOption: ifTrue:
				[aStream nextPut: $!].
			aStream nextPutAll: (pragma argumentAt: 1)]
		separatedBy: [aStream nextPutAll: ' && '].
	 aStream nextPutAll: ' */'; cr