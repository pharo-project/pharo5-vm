plugins
generatePlugin: aPlugin internal: aBoolean extraRules: aBlock
	" this method called back from plugin"
	^ CMakeAndroidPluginGenerator new
		generate: aPlugin for: self internal: aBoolean extraRules: aBlock