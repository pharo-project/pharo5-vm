remembered set
growRememberedSet
	| obj numSlots newObj base |
	<inline: false> "Don't ruin locality in remember:"
	<var: #base type: #'sqInt *'>
	obj := manager rememberedSetObj.
	numSlots := manager numSlotsOf: obj.
	self assert: numSlots >= 1024.
	newObj := manager allocatePinnedSlots: numSlots * 2.
	newObj ifNil:
		[newObj := manager allocatePinnedSlots: numSlots + 1024.
		 newObj ifNil:
			[self error: 'could not grow remembered set']].
	manager rememberedSetObj: newObj.
	base := manager firstIndexableField: newObj.
	0 to: rememberedSetSize - 1 do:
		[:i| base at: i put: (rememberedSet at: i)].
	"if growing in the middle of a GC, need to preserve marked status."
	(manager isMarked: obj) ifTrue:
		[manager
			setIsMarkedOf: newObj to: true;
			setIsMarkedOf: obj to: false].
	manager freeObject: obj.
	rememberedSet := base.
	rememberedSetLimit := manager numSlotsOf: newObj.
	self setRememberedSetRedZone