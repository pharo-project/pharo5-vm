accessing
abortBlock
	^vmMaker ifNotNil: [:vmm| vmm abortBlock]