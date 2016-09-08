inline primitive support
genLcIsIntegerObject: objectReg to: valueReg
	<option: #LowcodeVM>
	
	"Check for the immediate case"
	| isImmediate isLargePositiveInteger isLargeNegativeInteger falseResult trueResult cont |
	cogit MoveR: objectReg R: valueReg.
	cogit AndCq: objectMemory smallIntegerTag R: valueReg.
	isImmediate := cogit JumpNonZero: 0.
	
	"Check the non-immediate case"
	self genGetClassIndexOfNonImm: objectReg into: TempReg.
	cogit CmpCq: ClassLargePositiveInteger R: TempReg.
	isLargePositiveInteger := cogit JumpNonZero: 0.
	cogit CmpCq: ClassLargeNegativeInteger R: TempReg.
	isLargeNegativeInteger := cogit JumpNonZero: 0.
	cogit XorR: valueReg R: valueReg.
	falseResult := cogit Jump: 0.
	
	"True result"
	trueResult := cogit Label.
	isLargePositiveInteger jmpTarget: trueResult.
	isLargeNegativeInteger jmpTarget: trueResult.
	cogit MoveCq: 1 R: valueReg.
	
	"Return"
	cont := cogit Label.
	falseResult jmpTarget: cont.
	isImmediate jmpTarget: cont.
	cogit ssPushNativeRegister: valueReg.