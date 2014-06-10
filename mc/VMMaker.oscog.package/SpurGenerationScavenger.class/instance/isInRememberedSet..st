store check
isInRememberedSet: objOop
	0 to: rememberedSetSize - 1 do:
		[:i|
		(rememberedSet at: i) = objOop ifTrue:
			[^true]].
	^false