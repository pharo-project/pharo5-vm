plugin support
loadNewPlugin: pluginString
	| plugin plugins simulatorClasses |
	transcript cr; show: 'Looking for module ', pluginString.
	"but *why*??"
	(#('FloatArrayPlugin' 'Matrix2x3Plugin') includes: pluginString) ifTrue:
		[transcript show: ' ... defeated'. ^nil].
	plugins := InterpreterPlugin allSubclasses select: [:psc| psc moduleName asString = pluginString asString].
	simulatorClasses := (plugins
							select: [:psc| psc simulatorClass notNil]
							thenCollect: [:psc| psc simulatorClass]) asSet.
	simulatorClasses isEmpty ifTrue: [transcript show: ' ... not found'. ^nil].
	simulatorClasses size > 1 ifTrue: [^self error: 'This won''t work...'].
	plugins size > 1 ifTrue:
		[transcript show: '...multiple plugin classes; choosing ', plugins last name].
	plugin := simulatorClasses anyOne newFor: plugins last. "hopefully lowest in the hierarchy..."
	plugin setInterpreter: self. "Ignore return value from setInterpreter"
	(plugin respondsTo: #initialiseModule) ifTrue:
		[plugin initialiseModule ifFalse:
			[transcript show: ' ... initialiser failed'. ^nil]]. "module initialiser failed"
	pluginList := pluginList copyWith: (pluginString asString -> plugin).
	transcript show: ' ... loaded'.
	^pluginList last