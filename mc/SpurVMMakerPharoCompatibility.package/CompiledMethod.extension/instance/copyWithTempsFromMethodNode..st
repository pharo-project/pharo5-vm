*SpurVMMakerPharoCompatibility
copyWithTempsFromMethodNode: aMethodNode
	^self copyWithTrailerBytes: (
		CompiledMethodTrailer new tempNames: aMethodNode schematicTempNamesString)