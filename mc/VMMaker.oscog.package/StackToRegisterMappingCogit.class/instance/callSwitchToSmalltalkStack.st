inline ffi
callSwitchToSmalltalkStack
	<option: #LowcodeVM>
	"Restore the link register"
	backEnd hasVarBaseRegister ifTrue:
		[self MoveCq: self varBaseAddress R: VarBaseReg].
	backEnd hasLinkRegister ifTrue: [
		self MoveAw: coInterpreter instructionPointerAddress R: LinkReg
	].
	backEnd genLoadStackPointers.