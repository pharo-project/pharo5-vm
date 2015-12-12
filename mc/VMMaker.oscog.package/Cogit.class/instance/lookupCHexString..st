disassembly
lookupCHexString: aCHexString 
	<doNotGenerate>
	| pastLastZero shortened address |
	(aCHexString beginsWith: '0x') ifFalse:
		[^aCHexString].
	pastLastZero := aCHexString findFirst: [:c| c ~= $0 and: [c ~= $x]].
	shortened := pastLastZero = 0
					ifTrue: ['0x0']
					ifFalse:
						[(aCHexString size >= 16 and: [pastLastZero >= 4])
							ifTrue: [aCHexString copyReplaceFrom: 3 to: pastLastZero - 1 with: '']
							ifFalse: [aCHexString]].
	address := Number readFrom: (ReadStream on: shortened from: 3 to: shortened size) base: 16.
	(disassemblingMethod notNil
	 and: [address > disassemblingMethod
	 and: [address < (disassemblingMethod asInteger + disassemblingMethod blockSize)]]) ifTrue:
		[shortened := '.+', (address - disassemblingMethod asInteger printStringBase: 16 length: 4 padded: true)].
	^(self lookupAddress: (Number
								readFrom: (ReadStream on: shortened from: 3 to: shortened size)
								base: 16))
		ifNotNil: [:string| shortened, '=', string]
		ifNil: [shortened]