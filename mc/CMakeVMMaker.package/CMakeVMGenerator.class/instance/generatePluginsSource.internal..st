processing plugins
generatePluginsSource: plugins internal: bool

	plugins do: [:each | | plugin gen |
		plugin := Smalltalk at: each.
		gen := plugin generateFor: self internal: bool.
	].
	
