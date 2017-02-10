in-line cacheing
entryPointTagIsSelector: entryPoint
	"Answer if the entryPoint's tag is expected to be a selector reference, as opposed to a class tag."
	^entryPoint < methodZoneBase
	 or: [(entryPoint bitAnd: entryPointMask) = uncheckedEntryAlignment
	 or: [(entryPoint bitAnd: entryPointMask) = checkedEntryAlignment
		and: [(self cCoerceSimple: entryPoint - cmEntryOffset to: #'CogMethod *') cmType = CMOpenPIC]]]