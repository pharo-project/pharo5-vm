initialisation
initialize
	logger := TranscriptStream new.
	vmMaker := VMMaker default.
	vmMaker logger: logger.
	vmMaker addDependent: self.
	allPluginsSelectionsArray := Array new: self availableModules size withAll: false.
	internalPluginsSelectionsArray := Array new.
	externalPluginsSelectionsArray := Array new.