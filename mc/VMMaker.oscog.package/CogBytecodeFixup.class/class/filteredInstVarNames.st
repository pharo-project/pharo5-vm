translation
filteredInstVarNames
	"Override to eliminate bcpc,"
	^super filteredInstVarNames copyWithout: 'bcpc'