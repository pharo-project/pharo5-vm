simulation only
markAndTraceAndMaybeFreeStackPages: fullGCFlag
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter markAndTraceAndMaybeFreeStackPages: fullGCFlag