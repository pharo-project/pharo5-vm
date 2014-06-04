class initialization
newInitializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid
	"SimpleStackBasedCogit newInitializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid"
	"StackToRegisterMappingCogit newInitializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid"

	| v3Table v4Table |
	"N.B. Must do it backwards to evaluate AltBlockCreationBytecodeSize & BlockCreationBytecodeSize correctly."
	self newInitializeBytecodeTableForNewspeakV4.
	v4Table := generatorTable.
	AltBlockCreationBytecodeSize := BlockCreationBytecodeSize.
	AltNSSendIsPCAnnotated := NSSendIsPCAnnotated.
	self newInitializeBytecodeTableForNewspeakV3PlusClosures.
	v3Table := generatorTable.
	generatorTable := CArrayAccessor on: v3Table object, v4Table object