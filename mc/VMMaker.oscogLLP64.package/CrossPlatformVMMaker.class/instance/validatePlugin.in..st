generate sources
validatePlugin: plName in: listOfPlugins
	"Check that the class for the plugin exists, and answer that class.
	 No longer check that if the plugin requires platform files that at least
	 one platform subdirectory exists, not producing the source is not helpful."
	| plugin |
	plName isString
		ifTrue: [(listOfPlugins includes: plName)
				ifTrue: [plugin := Smalltalk classNamed: plName]]
		ifFalse: [((plName isBehavior
						and: [plName inheritsFrom: InterpreterPlugin])
					and: [listOfPlugins includes: plName name])
				ifTrue: [plugin := plName]].
	plugin ifNil: [^ self couldNotFindPluginClass: plName].
	plugin shouldBeTranslated ifFalse:
		[self error: 'untranslateable plugin class ', plName].
	^plugin