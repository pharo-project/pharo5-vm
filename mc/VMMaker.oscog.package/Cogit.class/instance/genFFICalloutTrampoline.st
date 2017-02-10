initialization
genFFICalloutTrampoline
	<option: #LowcodeVM>
	| startAddress |
	opcodeIndex := 0.
	backEnd hasLinkRegister ifTrue: [
		self MoveR: LinkReg Aw: coInterpreter instructionPointerAddress
	] ifFalse: [
		self PopR: backEnd registerToSaveIP.
		self MoveR: backEnd registerToSaveIP Aw: coInterpreter instructionPointerAddress
	].

	self CallR: TempReg.

	backEnd hasLinkRegister ifTrue: [
		self MoveAw: coInterpreter instructionPointerAddress R: LinkReg 
	] ifFalse: [
		self MoveAw: coInterpreter instructionPointerAddress R: backEnd registerToSaveIP.
		self PushR: backEnd registerToSaveIP.
	].

	self RetN: 0.

	startAddress := methodZoneBase.
	self outputInstructionsForGeneratedRuntimeAt: startAddress.
	self recordGeneratedRunTime: 'ceFFICalloutTrampoline' address: startAddress.
	self recordRunTimeObjectReferences.
	^ startAddress
