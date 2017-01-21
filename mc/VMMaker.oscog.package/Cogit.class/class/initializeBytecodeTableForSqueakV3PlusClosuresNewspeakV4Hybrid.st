class initialization
initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid
	"SimpleStackBasedCogit initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid"
	"StackToRegisterMappingCogit initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid"

	| v3Table v4Table |
	"N.B. Must do it backwards to evaluate AltBlockCreationBytecodeSize & BlockCreationBytecodeSize et al correctly."
	self initializeBytecodeTableForNewspeakV4.
	v4Table := generatorTable.
	AltBlockCreationBytecodeSize := BlockCreationBytecodeSize.
	AltNSSendIsPCAnnotated := NSSendIsPCAnnotated.
	AltFirstSpecialSelector := FirstSpecialSelector.
	AltNumSpecialSelectors := NumSpecialSelectors.
	self initializeBytecodeTableForSqueakV3PlusClosures.
	BytecodeSetHasExtensions := true.
	v3Table := generatorTable.
	generatorTable := CArrayAccessor on: v3Table object, v4Table object