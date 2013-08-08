generate sources
validatePlugin: plName in: listOfPlugins
	"The normal file release process bundles all files in the plugin directory, so don't bother users telling them 'there are no cross platform files for xyz' if there is are platform specific files present."
	| plugin |
	plName isString
		ifTrue: [(listOfPlugins includes: plName)
				ifTrue: [plugin := Smalltalk classNamed: plName]]
		ifFalse: [((plName isBehavior
						and: [plName inheritsFrom: InterpreterPlugin])
					and: [listOfPlugins includes: plName name])
				ifTrue: [plugin := plName]].
	plugin ifNil: [^ self couldNotFindPluginClass: plName].

	"Is there a cross-platform or platform files directory of the same name as this plugin?"
	plugin requiresPlatformFiles
		ifTrue: [(self platformPluginsDirectory directoryExists: plugin moduleName)
				ifFalse: [logger show: 'No platform specific files found for ' , plugin moduleName printString; cr.
					^ self couldNotFindPlatformFilesFor: plugin]].
	plugin requiresCrossPlatformFiles ifTrue: [
		((self platformPluginsDirectory directoryExists: plugin moduleName)
			or:[self crossPlatformPluginsDirectory directoryExists: plugin moduleName])
				ifFalse: [logger show: 'No cross platform files found for ' , plugin moduleName printString; cr.
					^ self couldNotFindPlatformFilesFor: plugin]].

	^plugin