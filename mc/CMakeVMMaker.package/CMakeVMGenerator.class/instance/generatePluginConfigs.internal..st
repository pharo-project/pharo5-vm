processing plugins
generatePluginConfigs: plugins internal: bool
	"Answers a collection of CMakePluginGenerator instances"
	
	^ plugins collect: [:each | | plugin |
		plugin := Smalltalk at: each.
		plugin generateFor: self internal: bool.
	].
	
