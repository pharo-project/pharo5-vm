initialize-release
initMaps
	map := Dictionary new: oldHeap memory size // 4.
	reverseMap := Dictionary new: oldHeap memory size // 4.
	classToIndex := Dictionary new: 1024.
	literalMap := IdentityDictionary new.
	methodClasses := Set new.
	installedPrototypes := Set new.
	installedMethodOops := Set new.
	classMetaclass := nil