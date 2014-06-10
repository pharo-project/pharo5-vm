class initialization
initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid
	"SimpleStackBasedCogit initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid"
	"StackToRegisterMappingCogit initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid"

	| v3Table v4Table |
	"N.B. Must do it backwards to evaluate AltBlockCreationBytecodeSize & BlockCreationBytecodeSize correctly."
	self initializeBytecodeTableForNewspeakV4.
	v4Table := generatorTable.
	AltBlockCreationBytecodeSize := BlockCreationBytecodeSize.
	AltNSSendIsPCAnnotated := NSSendIsPCAnnotated.
	self initializeBytecodeTableForNewspeakV3PlusClosures.
	v3Table := generatorTable.
	generatorTable := CArrayAccessor on: v3Table object, v4Table object