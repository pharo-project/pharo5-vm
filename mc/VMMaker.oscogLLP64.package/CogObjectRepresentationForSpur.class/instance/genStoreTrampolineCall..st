compile abstract instructions
genStoreTrampolineCall: instVarIndex
	<inline: true>
	instVarIndex >= (NumStoreTrampolines - 1)
		ifTrue: 
			[ cogit MoveCq: instVarIndex R: TempReg.
			  cogit CallRT: (ceStoreTrampolines at: NumStoreTrampolines - 1) ]
		ifFalse: 
			[ cogit CallRT: (ceStoreTrampolines at: instVarIndex) ].
	 cogit annotateBytecode: cogit Label