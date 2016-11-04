inline primitive support
genLcInstantiateOop: classOop indexableSize: indexableSize
	<option: #LowcodeVM>
	classOop ~= ReceiverResultReg ifTrue: [
		indexableSize = ReceiverResultReg ifTrue: [
			cogit MoveR: indexableSize R: TempReg.
		].
		cogit MoveR: classOop R: ReceiverResultReg
	].

	indexableSize ~= Arg0Reg ifTrue: [
		indexableSize = ReceiverResultReg ifTrue: [
			cogit MoveR: TempReg R: Arg0Reg.
		] ifFalse: [
			cogit MoveR: indexableSize R: Arg0Reg.
		]
	].

	cogit CallRT: ceInstantiateClassIndexableSizeTrampoline.

	cogit MoveR: TempReg R: classOop.
	cogit ssPushRegister: classOop.