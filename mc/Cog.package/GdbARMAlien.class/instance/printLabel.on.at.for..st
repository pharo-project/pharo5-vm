printing
printLabel: label on: aStream at: address for: aSymbolManager
	"Print label on aStream.  The label is either a triple of {type, printer, size} or a simple string."
	label isArray
		ifTrue: [label first == #literal
					ifTrue:
						[label size = 4 ifTrue:
							[aStream nextPutAll: label last; nextPut: $:; cr].
						 aStream
							nextPutAll: (address printStringBase: 16 length: 8 padded: true) asLowercase;
							nextPut: $:; space;
							nextPutAll: ((aSymbolManager objectMemory longAt: address) printStringBase: 16 length: 8 padded: true) asLowercase.
						 (aSymbolManager lookupAddress: (aSymbolManager objectMemory longAt: address)) ifNotNil:
							[:name| aStream space; nextPutAll: name]]
					ifFalse:
						[aStream
							nextPutAll: label first;
							nextPut: $:; cr;
							nextPutAll: (address printStringBase: 16 length: 8 padded: true) asLowercase;
							nextPut: $:; space;
							nextPutAll: (aSymbolManager perform: label second with: address) asString]]
		ifFalse: [aStream nextPutAll: label; nextPut: $:; cr]