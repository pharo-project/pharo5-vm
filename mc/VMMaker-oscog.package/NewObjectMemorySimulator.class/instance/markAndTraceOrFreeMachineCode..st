simulation only
markAndTraceOrFreeMachineCode: fullGCFlag
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter markAndTraceOrFreeMachineCode: fullGCFlag