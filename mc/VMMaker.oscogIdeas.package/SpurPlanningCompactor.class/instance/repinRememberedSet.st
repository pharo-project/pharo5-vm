private
repinRememberedSet
	<inline: true>
	scavenger rememberedSetSize > 0 ifTrue:
		[manager storePointerUnchecked: 0 ofObject: manager rememberedSetObj withValue: firstFieldOfRememberedSet].
	manager setIsPinnedOf: manager rememberedSetObj to: true.
	scavenger relocateRememberedSet