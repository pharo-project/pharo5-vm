simulation only
markAndTraceInterpreterOops: fullGCFlag
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter markAndTraceInterpreterOops: fullGCFlag