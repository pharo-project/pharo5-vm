*VMMaker-printing
storeOn: aStream base: base
	aStream nextPutAll: '#['.
	self
		do: [:each| each storeOn: aStream base: base]
		separatedBy: [aStream nextPut: $ ].
	aStream nextPut: $]