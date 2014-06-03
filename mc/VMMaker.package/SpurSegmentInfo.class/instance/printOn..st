printing
printOn: aStream
	<doNotGenerate>
	super printOn: aStream.
	(self class instVarNames copyReplaceAll: #('segSize') with: #('segSize' 'segLimit')) do:
		[:name| | iv |
		iv := self perform: name asSymbol.
		aStream space; nextPutAll: name; space; print: iv.
		(iv isInteger and: [iv ~= 0]) ifTrue:
			[aStream nextPut: $/.  iv storeOn: aStream base: 16]]