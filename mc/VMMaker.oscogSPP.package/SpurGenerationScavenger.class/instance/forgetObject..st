gc - global
forgetObject: objOop
	"Forget the argument."
	self assert: rememberedSetSize > 0.
	self assert: (manager isRemembered: objOop).
	manager setIsRememberedOf: objOop to: false.
	objOop = (rememberedSet at: rememberedSetSize - 1) ifFalse:
		[| index |
		 index := 0.
		 [index < rememberedSetSize] whileTrue:
			[objOop = (rememberedSet at: index) ifTrue:
				[rememberedSet at: index put: (rememberedSet at: rememberedSetSize - 1).
				 index := rememberedSetSize]]].
	rememberedSetSize := rememberedSetSize - 1.
	self assert: rememberedSetSize >= 0