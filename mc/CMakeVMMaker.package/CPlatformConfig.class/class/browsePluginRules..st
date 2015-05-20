utils
browsePluginRules: aPlugin
	
	| nm |
	(nm := aPlugin) isSymbol ifFalse: [
		nm := aPlugin name.
		].
	
	SystemNavigation default browseAllImplementorsOf: ('configure' , nm, ':' ) asSymbol
	