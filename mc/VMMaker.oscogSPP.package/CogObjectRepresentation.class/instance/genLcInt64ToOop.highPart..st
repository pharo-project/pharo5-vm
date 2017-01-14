inline primitive support
genLcInt64ToOop: valueLow highPart: valueHigh
	<option: #LowcodeVM>
	"Put the arguments in the correct registers"
	valueLow ~= ReceiverResultReg ifTrue: [
		valueHigh = ReceiverResultReg ifTrue: [
			cogit MoveR: valueHigh R: TempReg.
		].
		cogit MoveR: valueLow R: ReceiverResultReg.
	].

	valueHigh ~= Arg0Reg ifTrue: [
		valueHigh = ReceiverResultReg ifTrue: [
			cogit MoveR: TempReg R: Arg0Reg.
		] ifFalse: [
			cogit MoveR: valueHigh R: Arg0Reg.
		]
	].

	"Call the trampoline"
	cogit CallRT: ceSigned64BitIntegerTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushRegister: ReceiverResultReg.