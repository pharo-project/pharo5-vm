store check
remember: objOop
	(rememberedSetSize > 0
	 and: [(rememberedSet at: rememberedSetSize - 1) = objOop]) ifTrue:
		[self halt].
	^super remember: objOop