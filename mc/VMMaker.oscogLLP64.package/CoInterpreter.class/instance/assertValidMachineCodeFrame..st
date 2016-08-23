cog jit support
assertValidMachineCodeFrame: instrPtr
	<api>
	| cogMethod homeMethod |
	<var: #cogMethod type: #'CogBlockMethod *'>
	<var: #homeMethod type: #'CogMethod *'>
	self assert: (self isMachineCodeFrame: framePointer).
	cogMethod := self mframeCogMethod: framePointer.
	homeMethod := self asCogHomeMethod: cogMethod.
	self assert: (cogMethodZone methodFor: cogMethod) = homeMethod.
	self assert: (instrPtr > cogMethod asInteger
				and: [instrPtr < (homeMethod asInteger + homeMethod blockSize)])