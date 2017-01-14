inline primitive support
genLcIsBytes: objectReg to: valueReg
	<option: #LowcodeVM>
	
	"Check for integer"
	| isImmediate isNotBytes isCompiledMethod cont falseTarget |
	cogit MoveR: objectReg R: valueReg.
	cogit AndCq: objectMemory tagMask R: valueReg.
	isImmediate := cogit JumpNonZero: 0.
	
	"Get the format"
	self genGetFormatOf: objectReg into: valueReg.
	
	cogit CmpCq: objectMemory firstByteFormat R: valueReg.
	isNotBytes := cogit JumpLess: 0.
	cogit CmpCq: objectMemory firstCompiledMethodFormat R: valueReg.
	isCompiledMethod := cogit JumpGreaterOrEqual: 0.
	
	"True result"
	cogit MoveCq: 1 R: valueReg.
	cont := cogit Jump: 0.
	
	"False result"
	falseTarget := cogit Label.
	isImmediate jmpTarget: falseTarget.
	isNotBytes jmpTarget: falseTarget.
	isCompiledMethod jmpTarget: falseTarget.
	cogit MoveCq: 0 R: valueReg.

	"Return"
	cont jmpTarget: cogit Label.
	cogit ssPushNativeRegister: valueReg.