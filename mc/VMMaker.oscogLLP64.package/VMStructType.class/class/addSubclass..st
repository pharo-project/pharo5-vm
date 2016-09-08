accessing class hierarchy
addSubclass: aSubclass
	self voidStructTypeCache.
	^super addSubclass: aSubclass