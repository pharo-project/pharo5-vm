inline primitive support
genLcInstantiateOop: classOop indexableSize: indexableSize
	<option: #LowcodeVM>
	classOop ~= Arg0Reg ifTrue: [
		indexableSize = Arg0Reg ifTrue: [
			cogit MoveR: indexableSize R: TempReg.
		].
		cogit MoveR: classOop R: Arg0Reg
	].

	indexableSize ~= Arg1Reg ifTrue: [
		indexableSize = Arg0Reg ifTrue: [
			cogit MoveR: TempReg R: Arg1Reg.
		] ifFalse: [
			cogit MoveR: indexableSize R: Arg1Reg.
		]
	].

	cogit CallRT: ceInstantiateClassIndexableSizeTrampoline.

	cogit MoveR: TempReg R: classOop.
	cogit ssPushRegister: classOop.