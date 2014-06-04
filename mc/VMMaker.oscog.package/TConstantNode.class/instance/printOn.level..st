printing
printOn: aStream level: level
	value isSymbol
		ifTrue: [aStream nextPutAll: (value copyWithout: $:)]
		ifFalse: [value storeOn: aStream]