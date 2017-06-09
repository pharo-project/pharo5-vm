initialization
initializeRememberedSet
	| obj |
	obj := manager rememberedSetObj.
	obj = manager nilObject
		ifTrue:
			[obj := manager allocatePinnedSlots: 1024.
			 manager rememberedSetObj: obj]
		ifFalse: "The Spur32to64BitBootstrap failed to set the type of rememberedSetObj to 64-bit indexability.
				 This is unimportant except for simulation; rememberedSet is declared as sqInt *, but in to have
				 firstIndexableField: below answer a suitable type the format must be wordIndexableFormat."
			[manager setFormatOf: obj to: manager wordIndexableFormat].
	self assert: (manager formatOf: obj) = manager wordIndexableFormat.
	self assert: (manager isPinned: obj).
	rememberedSet := manager firstIndexableField: obj.
	rememberedSetSize := 0.
	rememberedSetLimit := manager numSlotsOf: obj.
	self setRememberedSetRedZone