inline primitive support
genLcIsWordsOrBytes: objectReg to: valueReg
	<option: #LowcodeVM>
	| isInteger isNotBytes falseTarget cont |
	
	"Check for integer"
	cogit MoveR: objectReg R: TempReg.
	cogit AndCq: 1 R: TempReg.
	isInteger := cogit JumpNonZero: 0.

	"Get the class format"
	self genGetClassFormatOfNonInt: objectReg into: valueReg scratchReg: TempReg.

	"Hack: consider a compiled method as bytes too."
	cogit CmpCq: 6 R: valueReg.
	isNotBytes := cogit JumpLess: 0.

	"True result"
	cogit MoveCq: 1 R: valueReg.
	cont := cogit Jump: 0.

	"False result"
	falseTarget := cogit Label.
	isInteger jmpTarget: falseTarget.
	isNotBytes jmpTarget: falseTarget.
	cogit MoveCq: 0 R: valueReg.

	"Return"
	cont jmpTarget: cogit Label.
	cogit ssPushNativeRegister: valueReg.