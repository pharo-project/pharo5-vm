initialization
primitiveTableString
	"Interpreter initializePrimitiveTable primitiveTableString"
	| table |
	table := self primitiveTable.
	^ String
		streamContents: [:s | 
			s nextPut: ${.
			table
				withIndexDo: [:primSpec :index | s cr; tab;
					nextPutAll: '/* ';
					nextPutAll: (index - 1) printString;
					nextPutAll: '*/ ';
					nextPutAll: '(void *)';
					nextPutAll: primSpec;
					nextPut: $,].
			s cr; nextPutAll: ' 0 }']