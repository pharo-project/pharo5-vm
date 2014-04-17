plugins
generatePlugin: aPlugin internal: aBoolean extraRules: aBlock
	" this method called back from plugin"
	^ CMakePluginGenerator new
		generate: aPlugin for: self internal: aBoolean extraRules: aBlock