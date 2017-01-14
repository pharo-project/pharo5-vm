inline primitive support
genLcIsWords: objectReg to: valueReg
	<option: #LowcodeVM>
	| isInteger isNotWords falseTarget cont |
	
	"Check for integer"
	cogit MoveR: objectReg R: TempReg.
	cogit AndCq: 1 R: TempReg.
	isInteger := cogit JumpNonZero: 0.

	"Get the class format"
	self genGetClassFormatOfNonInt: objectReg into: valueReg scratchReg: TempReg.

	"Check for the words format"
	cogit CmpCq: 6 R: valueReg.
	isNotWords := cogit JumpNonZero: 0.

	"True result"
	cogit MoveCq: 1 R: valueReg.
	cont := cogit Jump: 0.

	"False result"
	falseTarget := cogit Label.
	isInteger jmpTarget: falseTarget.
	isNotWords jmpTarget: falseTarget.
	cogit MoveCq: 0 R: valueReg.

	"Return"
	cont jmpTarget: cogit Label.
	cogit ssPushNativeRegister: valueReg.