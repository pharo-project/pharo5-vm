as yet unclassified
targetPropertyAt: aPropName put: aValue
	"set target's properties"
	
	self cmd: 'set_property' params: 'TARGET ', config executableName , 
	' PROPERTY ', aPropName , ' ' , aValue.
