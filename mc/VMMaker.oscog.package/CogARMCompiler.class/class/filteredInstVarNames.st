translation
filteredInstVarNames
	"Edit such that conditionOrNil is amongst the char size vars opcode machineCodeSize and maxSize."
	^(super filteredInstVarNames copyWithout: 'conditionOrNil')
		copyReplaceFrom: 4 to: 3 with: #('conditionOrNil')