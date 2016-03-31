compile abstract instructions
genStoreTrampolineCall: instVarIndex
	<inline: true>
	instVarIndex < self numStoreTrampolines
		ifFalse: 
			[ cogit MoveCq: instVarIndex R: TempReg.
			  cogit CallRT: (ceStoreTrampolines at: self numStoreTrampolines) ]
		ifTrue: 
			[ cogit CallRT: (ceStoreTrampolines at: instVarIndex) ].
	 cogit annotateBytecode: cogit Label