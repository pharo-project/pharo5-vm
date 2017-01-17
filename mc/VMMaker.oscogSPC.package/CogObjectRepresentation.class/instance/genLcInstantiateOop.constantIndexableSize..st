inline primitive support
genLcInstantiateOop: classOop constantIndexableSize: indexableSize
	<option: #LowcodeVM>
	classOop ~= Arg0Reg ifTrue: [cogit MoveR: classOop R: Arg0Reg].
	cogit MoveCq: indexableSize R: Arg1Reg.
	cogit CallRT: ceInstantiateClassIndexableSizeTrampoline.

	cogit MoveR: TempReg R: classOop.
	cogit ssPushRegister: classOop.