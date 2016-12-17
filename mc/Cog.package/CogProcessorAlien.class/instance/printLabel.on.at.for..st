printing
printLabel: label on: aStream at: address for: aSymbolManager
	"Print label on aStream.  The label is either a triple of {type, printer, size} or a simple string."
	label isArray
		ifTrue: [label first == #literal
					ifTrue:
						[aStream
							nextPutAll: (address printStringBase: 16 length: 8 padded: true) asLowercase;
							nextPut: $:; space;
							nextPutAll: (aSymbolManager lookupAddress: (aSymbolManager objectMemory longAt: address))]
					ifFalse:
						[aStream
							nextPutAll: label first;
							nextPut: $:; cr;
							nextPutAll: (address printStringBase: 16 length: 8 padded: true) asLowercase;
							nextPut: $:; space;
							nextPutAll: (aSymbolManager perform: label second with: address) asString]]
		ifFalse: [aStream nextPutAll: label; nextPut: $:; cr]