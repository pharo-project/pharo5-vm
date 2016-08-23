plugin lists
allPluginsDo: aBlock 
	"for each class that should be an external plugin, evaluate aBlock"
	self externalPluginsDo: aBlock.
	self internalPluginsDo: aBlock.