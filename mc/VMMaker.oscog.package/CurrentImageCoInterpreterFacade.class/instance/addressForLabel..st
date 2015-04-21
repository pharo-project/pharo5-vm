labels
addressForLabel: l
	^variables
		at: l
		ifAbsentPut:
			[(self isLabelRelativeToCogitVarBaseReg: l)
				ifTrue: [cogit fakeAddressFor: l index: variables size + 48]
				ifFalse: [variables size * 4 + self variablesBase]]