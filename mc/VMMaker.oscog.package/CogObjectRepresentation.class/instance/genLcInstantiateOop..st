inline primitive support
genLcInstantiateOop: classOop
	<option: #LowcodeVM>
	classOop ~= ReceiverResultReg ifTrue: [cogit MoveR: classOop R: ReceiverResultReg].
	cogit CallRT: ceInstantiateClassTrampoline.

	cogit MoveR: TempReg R: classOop.
	cogit ssPushRegister: classOop.