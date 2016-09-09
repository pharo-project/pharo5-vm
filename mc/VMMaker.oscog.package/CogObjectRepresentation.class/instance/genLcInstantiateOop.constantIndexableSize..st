inline primitive support
genLcInstantiateOop: classOop constantIndexableSize: indexableSize
	<option: #LowcodeVM>
	classOop ~= ReceiverResultReg ifTrue: [cogit MoveR: classOop R: ReceiverResultReg].
	cogit MoveCq: indexableSize R: Arg0Reg.
	cogit CallRT: ceInstantiateClassIndexableSizeTrampoline.

	cogit MoveR: TempReg R: classOop.
	cogit ssPushRegister: classOop.