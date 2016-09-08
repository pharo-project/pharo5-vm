inline primitive support
genLcOop: object toInt64: valueLow highPart: valueHigh
	<option: #LowcodeVM>
	object ~= ReceiverResultReg ifTrue: [ cogit MoveR: object R: ReceiverResultReg.].
	cogit CallRT: ceSigned64BitValueOfTrampoline.

	Arg0Reg ~= valueHigh ifTrue: [cogit MoveR: Arg0Reg R: valueHigh].
	cogit MoveR: TempReg R: valueLow.

	cogit ssPushNativeRegister: valueLow secondRegister: valueHigh.