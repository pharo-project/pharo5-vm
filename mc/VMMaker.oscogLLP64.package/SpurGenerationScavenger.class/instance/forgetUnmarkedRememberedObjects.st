gc - global
forgetUnmarkedRememberedObjects
	"Remove all unmarked objects from the remembered set.
	 This is for global scan-mark GC."
	| index |
	index := 0.
	[index < rememberedSetSize] whileTrue:
		[| obj |
		 obj := rememberedSet at: index.
		 (manager isMarked: obj)
			ifTrue: [index := index + 1]
			ifFalse: "unmarked; remove by overwriting with last element."
				[manager setIsRememberedOf: obj to: false.
				 rememberedSetSize := rememberedSetSize - 1.
				 rememberedSet at: index put: (rememberedSet at: rememberedSetSize)]].
	self assert: rememberedSetSize >= 0