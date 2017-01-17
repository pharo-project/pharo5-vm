plugin lists
internalPluginsDo: aBlock 
	"for each class that should be an internal plugin, evaluate aBlock"
	self plugins: internalPlugins do: aBlock