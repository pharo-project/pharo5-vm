inline primitive support
genLcIsPointers: objectReg to: valueReg
	<option: #LowcodeVM>
	
	"Check for immediate"
	| isImmediate isNotPointers cont falseTarget |
	cogit MoveR: objectReg R: valueReg.
	cogit AndCq: objectMemory tagMask R: valueReg.
	isImmediate := cogit JumpNonZero: 0.
	
	"Get the format"
	self genGetFormatOf: objectReg into: valueReg.
	
	cogit CmpCq: 9 R: valueReg.
	isNotPointers := cogit JumpGreaterOrEqual: 0.
	
	"True result"
	cogit MoveCq: 1 R: valueReg.
	cont := cogit Jump: 0.
	
	"False result"
	falseTarget := cogit Label.
	isImmediate jmpTarget: falseTarget.
	isNotPointers jmpTarget: falseTarget.
	cogit MoveCq: 0 R: valueReg.

	"Return"
	cont jmpTarget: cogit Label.
	cogit ssPushNativeRegister: valueReg.