labels
isLabelRelativeToCogitVarBaseReg: l
	coInterpreter class
		instVarIndexFor: l
		ifAbsent:
			[objectMemory class
				instVarIndexFor: l
				ifAbsent: [^false]].
	^true