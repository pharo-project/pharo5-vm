compile abstract instructions
genSSPushSlot: index reg: baseReg
	^cogit ssPushBase: baseReg offset: (self slotOffsetOfInstVarIndex: index)