inline primitive support
genLcPointerToOop: pointer class: pointerClass
	<option: #LowcodeVM>
	cogit PushR: pointer.
	cogit annotate: (cogit MoveCw: pointerClass R: Arg0Reg) objRef: pointerClass.
	cogit MoveCq: BytesPerOop R: Arg1Reg.
	cogit CallRT: ceInstantiateClassIndexableSizeTrampoline.

	cogit PopR: pointer.
	cogit MoveR: pointer Mw: BaseHeaderSize r: TempReg.

	cogit MoveR: TempReg R: pointer.
	cogit ssPushRegister: pointer.