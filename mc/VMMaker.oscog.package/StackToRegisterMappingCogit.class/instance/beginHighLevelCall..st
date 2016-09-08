inline ffi
beginHighLevelCall: alignment
	<option: #LowcodeVM>
	| mask actualAlignment |

	"Store the smalltalk pointers"
	self ssFlushAll.
	self MoveR: SPReg Aw: coInterpreter stackPointerAddress.
	self MoveR: FPReg Aw: coInterpreter framePointerAddress.
	backEnd hasLinkRegister ifTrue: [
		self MoveAw: coInterpreter instructionPointerAddress R: LinkReg
	].

	"Load the C pointers"
	self MoveAw: self cStackPointerAddress R: SPReg.

	"Load the native stack frame pointer"
	self MoveMw: self frameOffsetOfNativeFramePointer r: FPReg R: FPReg.
	self SubCq: 1 R: FPReg.

	actualAlignment := (alignment max: BytesPerWord).
	actualAlignment > BytesPerWord ifTrue: [
		mask := actualAlignment negated.
		self AndCq: mask R: SPReg.
	].
	currentCallCleanUpSize := 0.