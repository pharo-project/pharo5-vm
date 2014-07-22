initialization
initializeRememberedSet
	| obj |
	obj := manager rememberedSetObj.
	obj = manager nilObject ifTrue:
		[obj := manager allocatePinnedSlots: 1024.
		 manager rememberedSetObj: obj].
	rememberedSet := manager firstIndexableField: obj.
	rememberedSetSize := 0.
	rememberedSetLimit := manager numSlotsOf: obj.
	rememberedSetRedZone := rememberedSetLimit * 3 + 3 // 4