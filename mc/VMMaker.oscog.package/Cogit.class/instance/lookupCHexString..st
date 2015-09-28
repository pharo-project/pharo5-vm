disassembly
lookupCHexString: aCHexString 
	<doNotGenerate>
	| pastLastZero |
	(aCHexString beginsWith: '0x') ifFalse:
		[^aCHexString].
	^(self lookupAddress: (Number
								readFrom: (ReadStream on: aCHexString from: 3 to: aCHexString size)
								base: 16))
		ifNotNil: [:string| aCHexString, '=', string]
		ifNil: [pastLastZero := aCHexString findFirst: [:c| c ~= $0 and: [c ~= $x]].
			pastLastZero = 0 ifTrue: [pastLastZero := aCHexString size + 1].
			(aCHexString size >= 16 and: [pastLastZero >= 4])
				ifTrue: [aCHexString copyReplaceFrom: 3 to: pastLastZero - 1 with: '']
				ifFalse: [aCHexString]]