inline ffi
callSwitchToSmalltalkStack
	<option: #LowcodeVM>
	"Restore the link register"
	backEnd hasLinkRegister ifTrue: [
		self MoveAw: coInterpreter instructionPointerAddress R: LinkReg
	].
	backEnd genLoadStackPointers.