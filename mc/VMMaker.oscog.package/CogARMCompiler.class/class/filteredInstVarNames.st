translation
filteredInstVarNames
	"Edit such that cond is amongst the char size vars opcode machineCodeSize and maxSize."
	^(super filteredInstVarNames copyWithout: 'cond')
		copyReplaceFrom: 4 to: 3 with: #('cond')