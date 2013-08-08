as yet unclassified
targetPropertyAt: aPropName qput: aValue
	"set target's properties, put value in quotes"
	
	^ self targetPropertyAt: aPropName put: (aValue copyReplaceAll: '"' with: '\"').