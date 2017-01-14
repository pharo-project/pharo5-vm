inline primitive generators generated code
genLowcodeLocalFrameSize
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| size |
	size := extA.

	self assert: needsFrame.
	hasNativeFrame := true.
	"Mark the stack frame"
	self annotate: (self MoveCw: (objectMemory splObj: LowcodeContextMark) R: TempReg) objRef: (objectMemory splObj: LowcodeContextMark).
	self MoveR: TempReg Mw: self frameOffsetOfNativeFrameMark r: FPReg.
	"Fetch the stack"
	self MoveAw: coInterpreter nativeStackPointerAddress R: TempReg.
	self AddCq: 1 R: TempReg.
	self MoveR: TempReg Mw: self frameOffsetOfPreviousNativeStackPointer r: FPReg.
	"Store the frame pointer"
	self SubCq: size R: TempReg.
	self MoveR: TempReg Mw: self frameOffsetOfNativeFramePointer r: FPReg.
	"Store the new stack pointer"
	self MoveR: TempReg Mw: self frameOffsetOfNativeStackPointer r: FPReg.
	"Allocate space for the locals"
	self SubCq: 1 + coInterpreter defaultNativeStackFrameSize R: TempReg.
	self MoveR: TempReg Aw: coInterpreter nativeStackPointerAddress.

	extA := 0.
	^ 0

