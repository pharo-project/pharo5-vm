initialization
initialize
	rememberedSet := CArrayAccessor on: (Array new: RememberedSetLimit).
	rememberedSetSize := 0.
	tenuringThreshold := 0.
	tenuringProportion := 0.9