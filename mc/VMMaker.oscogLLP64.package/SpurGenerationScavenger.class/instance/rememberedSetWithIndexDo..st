debug support
rememberedSetWithIndexDo: aBlock
	0 to: rememberedSetSize - 1 do:
		[:i| aBlock value: (rememberedSet at: i) value: i]