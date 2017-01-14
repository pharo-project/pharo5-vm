instance creation
doPrimitive: primitiveName 
	| proxy plugin |
	proxy := InterpreterProxy new.
	proxy loadStackFrom: thisContext sender.
	plugin := self simulatorClass new.
	plugin setInterpreter: proxy.
	(plugin respondsTo: #initialiseModule) ifTrue:[plugin initialiseModule].
	plugin perform: primitiveName asSymbol.
	^ proxy stackValue: 0