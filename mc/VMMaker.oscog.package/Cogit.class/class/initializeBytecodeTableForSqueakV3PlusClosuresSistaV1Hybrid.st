class initialization
initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid
	"SimpleStackBasedCogit initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid"
	"StackToRegisterMappingCogit initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid"

	| v3Table v1Table |
	"N.B. Must do it backwards to evaluate AltBlockCreationBytecodeSize & BlockCreationBytecodeSize et al correctly."
	self initializeBytecodeTableForSistaV1.
	v1Table := generatorTable.
	AltBlockCreationBytecodeSize := BlockCreationBytecodeSize.
	AltFirstSpecialSelector := FirstSpecialSelector.
	AltNumSpecialSelectors := NumSpecialSelectors.
	self initializeBytecodeTableForSqueakV3PlusClosures.
	BytecodeSetHasExtensions := true.
	v3Table := generatorTable.
	generatorTable := CArrayAccessor on: v3Table object, v1Table object