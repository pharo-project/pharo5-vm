private
unpinRememberedSet
	<inline: true>
	firstFieldOfRememberedSet := manager fetchPointer: 0 ofObject: manager rememberedSetObj.
	manager setIsPinnedOf: manager rememberedSetObj to: false