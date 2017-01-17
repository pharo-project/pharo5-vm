jit - api
isNonLocalReturnPC: retpc
	<doNotGenerate>
	"Answer if the instruction preceding retpc is a call instruction."
	(backEnd isCallPrecedingReturnPC: retpc) ifFalse:
		[^false].
	^(backEnd callTargetFromReturnAddress: retpc) = ceNonLocalReturnTrampoline