translation
filteredInstVarNames
	"Eliminate bcpc, which is development-time only."
	^super filteredInstVarNames copyWithout: 'bcpc'