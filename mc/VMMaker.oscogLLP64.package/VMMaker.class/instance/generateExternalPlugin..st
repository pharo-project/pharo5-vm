generate sources
generateExternalPlugin: pluginName 
	"generate the named external plugin"
	| exports plugin |

	"Refuse to translate this plugin if it requires platform specific files and they are not present."
	[plugin := self validateExternalPlugin: pluginName]
		on: VMMakerException
		do: [:ex|
			logger show: 'external plugin ' , plugin name , ' failed to validate: ' , ex messageText; cr.
			^self].

	[exports := plugin
					translateInDirectory: (self externalPluginsDirectoryFor: plugin)
					doInlining: inline]
		on:  ProvideAnswerNotification
		do: [:ex|
			ex tag == #logger
				ifTrue: [ex resume: logger]
				ifFalse: [ex pass]].
	exports ifNotNil: "if exp is nil we skip this since the plugin was already up to date"
		[logger show: 'external plugin ' , plugin name , ' generated as ' , plugin moduleName; cr.
		 self export: exports forExternalPlugin: plugin.
		 self processFilesForExternalPlugin: plugin]