initialize-release
initMaps
	map := Dictionary new: heap32 memory size // 32.
	reverseMap := Dictionary new: heap32 memory size // 32.
	literalMap := IdentityDictionary new