bytecode generator support
ssTopNeedsStoreCheck
	<inline: true>
	| needsStoreCheck |
	needsStoreCheck := (extB noMask: 1) and: [ (objectRepresentation isUnannotatableConstant: self ssTop) not ].
	extB := 0.
	^ needsStoreCheck