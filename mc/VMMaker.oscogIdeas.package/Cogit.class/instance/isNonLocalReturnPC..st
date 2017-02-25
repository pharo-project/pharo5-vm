jit - api
isNonLocalReturnPC: retpc
	<doNotGenerate>
	"Answer if the instruction preceding retpc is a call instruction."
	^(backEnd isCallPrecedingReturnPC: retpc)
	 and: [(backEnd callTargetFromReturnAddress: retpc) = ceNonLocalReturnTrampoline]