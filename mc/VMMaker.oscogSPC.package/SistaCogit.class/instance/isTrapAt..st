simulation only
isTrapAt: retpc
	"For stack depth checking."
	<doNotGenerate>
	^(backEnd isCallPrecedingReturnPC: retpc)
	 and: [(backEnd callTargetFromReturnAddress: retpc) = ceTrapTrampoline]