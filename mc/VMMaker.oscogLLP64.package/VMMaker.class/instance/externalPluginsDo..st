plugin lists
externalPluginsDo: aBlock 
	"for each class that should be an external plugin, evaluate aBlock"
	self plugins: externalPlugins do: aBlock