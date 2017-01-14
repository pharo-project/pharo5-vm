generate sources
privateGenerateInternalPlugin: pluginName 
	"generate the named internal plugin"
	| plugin |
	"Refuse translate this plugin if it requires platform specific files and  
	they are not present."
	plugin := self validateInternalPlugin: pluginName.

	plugin ifNil:
		[^self couldNotFindPluginClass: pluginName].
	[plugin
			translateInDirectory: (self internalPluginsDirectoryFor: plugin)
			doInlining: inline]
		on:  ProvideAnswerNotification
		do: [:ex|
			ex tag == #logger
				ifTrue: [ex resume: logger]
				ifFalse: [ex pass]].
	logger show: 'internal plugin ' , plugin name , ' generated as ' , plugin moduleName; cr.
	self processFilesForInternalPlugin: plugin