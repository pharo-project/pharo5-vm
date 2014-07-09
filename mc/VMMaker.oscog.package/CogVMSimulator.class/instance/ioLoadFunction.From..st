plugin support
ioLoadFunction: functionString From: pluginString
	"Load and return the requested function from a module"
	| firstTime plugin fnSymbol |
	firstTime := false.
	fnSymbol := functionString asSymbol.
	transcript
		cr;
		show: '(', byteCount printString, ') Looking for ', functionString, ' in ',
				(pluginString isEmpty ifTrue:['vm'] ifFalse:[pluginString]).
	functionString = breakSelector ifTrue: [self halt: breakSelector].
	plugin := pluginList 
				detect:[:any| any key = pluginString asString]
				ifNone:
					[firstTime := true.
					self loadNewPlugin: pluginString].
	plugin ifNil:
		[firstTime ifTrue: [transcript cr; show: 'Failed ... primitive not in plugin'].
		 ^0].
	plugin := plugin value.
	mappedPluginEntries doWithIndex:
		[:pluginAndName :index|
		((pluginAndName at: 1) == plugin 
		and:[(pluginAndName at: 2) == fnSymbol]) ifTrue:
			[^index]].
	(plugin respondsTo: fnSymbol) ifFalse:
		[firstTime ifTrue: [transcript cr; show: 'Failed ... primitive not in plugin'].
		 ^0].
	mappedPluginEntries addLast: (Array
									with: plugin
									with: fnSymbol
									with: [plugin perform: fnSymbol. self]).
	"Transcript show: ' ... okay'."
	transcript cr.
	^ mappedPluginEntries size