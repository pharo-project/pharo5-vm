as yet unclassified
isSuitablePluginForPlatform: platName

	PlatformId isNil ifTrue: [
		self inform: ' please set the appropriate PlatformId, before generating ', self name, ' code.' .
		^ false
		].
	^ true
