initialization
primitiveTableStringFor: table
	"StackInterpreter initializePrimitiveTable primitiveTableString"
	^String streamContents:
		[:s | 
		s nextPut: ${.
		table withIndexDo:
			[:primSpec :index |
			s
				crtab;
				nextPutAll: '/* ';
				print: index - 1;
				nextPutAll: ' */ ';
				nextPutAll: (primSpec isString
								ifTrue: [primSpec == #primitiveFail
											ifTrue: ['(void (*)(void))0']
											ifFalse: [primSpec]]
								ifFalse: ['(void (*)(void))', primSpec printString]);
				nextPut: $,].
			s cr; nextPutAll: ' 0 }']