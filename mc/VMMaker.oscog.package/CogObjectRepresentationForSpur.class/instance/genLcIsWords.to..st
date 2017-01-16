inline primitive support
genLcIsWords: objectReg to: valueReg
	<option: #LowcodeVM>
	
	"Check for immediate"
	| isImmediate isNotWords cont falseTarget isBelowRange isAboveRange |
	cogit MoveR: objectReg R: valueReg.
	cogit AndCq: objectMemory tagMask R: valueReg.
	isImmediate := cogit JumpNonZero: 0.
	
	"Get the format"
	self genGetFormatOf: objectReg into: valueReg.
	
	"Hack: consider a compiled method as bytes too."
	BytesPerWord = 8 ifTrue: [
		cogit CmpCq: objectMemory firstLongFormat R: valueReg.
		isBelowRange := cogit JumpLess: 0.
		cogit CmpCq: objectMemory firstShortFormat R: valueReg.
		isAboveRange := cogit JumpGreaterOrEqual: 0.
	] ifFalse: [ 
		cogit CmpCq: objectMemory firstLongFormat R: valueReg.
		isNotWords := cogit JumpNonZero: 0.
	].
	
	"True result"
	cogit MoveCq: 1 R: valueReg.
	cont := cogit Jump: 0.
	
	"False result"
	falseTarget := cogit Label.
	isImmediate jmpTarget: falseTarget.
	BytesPerWord = 4 ifTrue: [
		isNotWords jmpTarget: falseTarget.
	] ifFalse: [ 
		isBelowRange jmpTarget: falseTarget.
		isAboveRange jmpTarget: falseTarget.
	].
	cogit MoveCq: 0 R: valueReg.

	"Return"
	cont jmpTarget: cogit Label.
	cogit ssPushNativeRegister: valueReg.