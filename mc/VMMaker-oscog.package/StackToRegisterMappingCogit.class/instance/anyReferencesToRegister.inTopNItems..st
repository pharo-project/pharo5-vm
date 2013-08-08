simulation stack
anyReferencesToRegister: reg inTopNItems: n
	| regMask |
	regMask := self registerMaskFor: reg.
	simStackPtr to: simStackPtr - n + 1 by: -1 do:
		[:i|
		((self simStackAt: i) registerMask anyMask: regMask) ifTrue:
			[^true]].
	^false