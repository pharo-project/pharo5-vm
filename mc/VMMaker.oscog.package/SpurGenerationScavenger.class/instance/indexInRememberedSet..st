store check
indexInRememberedSet: objOop
	<doNotGenerate>
	0 to: rememberedSetSize - 1 do:
		[:i|
		(rememberedSet at: i) = objOop ifTrue:
			[^i]].
	^nil