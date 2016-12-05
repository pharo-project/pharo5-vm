simulation stack
anyReferencesToRegister: reg inAllButTopNItems: n
	| regMask |
	regMask := self registerMaskFor: reg.
	simStackPtr - n to: 0 by: -1 do:
		[:i|
		((self simStackAt: i) registerMask anyMask: regMask) ifTrue:
			[^true]].
	^false