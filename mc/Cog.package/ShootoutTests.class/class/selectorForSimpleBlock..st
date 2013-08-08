benchmark scripts
selectorForSimpleBlock: aBlock
	| is |
	is := InstructionStream on: aBlock method.
	is pc: aBlock startpc.
	is scanFor:
		[:x| | selectorOrScanner |
		(selectorOrScanner := is selectorToSendOrSelf) ~~ is ifTrue:
			[^selectorOrScanner].
		false].
	^nil