disassembly
lookupCHexString: aCHexString 
	<doNotGenerate>
	(aCHexString beginsWith: '0x') ifFalse:
		[^aCHexString].
	^(self lookupAddress: (Number
								readFrom: (aCHexString copyFrom: 3 to: aCHexString size) asUppercase readStream
								base: 16))
		ifNotNil: [:string| aCHexString, '=', string]
		ifNil: [aCHexString]