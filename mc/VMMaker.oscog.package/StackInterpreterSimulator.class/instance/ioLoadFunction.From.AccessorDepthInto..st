plugin support
ioLoadFunction: functionString From: pluginString AccessorDepthInto: accessorDepthPtr
	"Load and return the requested function from a module.
	 Assign the accessor depth through accessorDepthPtr.
	 N.B. The actual code lives in platforms/Cross/vm/sqNamedPrims.h"
	| firstTime plugin fnSymbol |
	firstTime := false.
	fnSymbol := functionString asSymbol.
	transcript
		cr;
		show: '(', byteCount printString, ') Looking for ', functionString, ' in ',
				(pluginString isEmpty ifTrue:['vm'] ifFalse:[pluginString]).
	breakSelector ifNotNil:
		[(self str: functionString n: breakSelector cmp: functionString size) = 0 ifTrue:
			[self halt: functionString]].
	plugin := pluginList 
				detect: [:any| any key = pluginString asString]
				ifNone:
					[firstTime := true.
					 self loadNewPlugin: pluginString].
	plugin ifNil:
		[firstTime ifTrue: [transcript cr; show: 'Failed ... primitive not in plugin'].
		 ^0].
	plugin := plugin value.
	"mappedPluginEntries select: [:tuple| tuple first = plugin] an OrderedCollection({an UnixOSProcessPlugin . #getModuleName . [closure] in [] in StackInterpreterSimulatorLSB(StackInterpreter)>>tryLoadNewPlugin:pluginEntries: . nil} {an UnixOSProcessPlugin . #setInterpreter . [closure] in [] in StackInterpreterSimulatorLSB(StackInterpreter)>>tryLoadNewPlugin:pluginEntries: . nil})"
	mappedPluginEntries doWithIndex:
		[:pluginAndName :index|
		 ((pluginAndName at: 1) == plugin 
		  and:[(pluginAndName at: 2) == fnSymbol]) ifTrue:
			[firstTime ifTrue: [transcript show: ' ... okay'; cr].
			 accessorDepthPtr at: 0 put: (pluginAndName at: 4).
			 ^index]].
	firstTime ifTrue: [transcript cr; show: 'Failed ... primitive not in plugin'].
	^0