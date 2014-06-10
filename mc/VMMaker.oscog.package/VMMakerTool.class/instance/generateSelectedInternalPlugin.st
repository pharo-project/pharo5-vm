generate sources
generateSelectedInternalPlugin

	| pluginName |
	pluginName := self internalModules
						at: self currentInternalModuleIndex
						ifAbsent: [^self inform: 'no such plugin'].
	vmMaker interpreterClass
		ifNil: [^self inform: 'please set an interpreter class']
		ifNotNil: [:interpreterClass| interpreterClass initialize].
	self checkOK ifTrue:
		[[(Smalltalk classNamed: pluginName) touch.
		  vmMaker generateInternalPlugin: pluginName]
			on: VMMakerException
			do: [:ex| self inform: ex messageText]]