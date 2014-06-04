generate sources
generateSelectedExternalPlugin

	| pluginName |
	pluginName := self externalModules
						at: self currentExternalModuleIndex
						ifAbsent: [^self inform: 'no such plugin'].
	vmMaker interpreterClass
		ifNil: [^self inform: 'please set an interpreter class']
		ifNotNil: [:interpreterClass| interpreterClass initialize].
	self checkOK ifTrue:
		[[(Smalltalk classNamed: pluginName) touch.
		  vmMaker generateExternalPlugin: pluginName; logDateAndTime]
			on: VMMakerException
			do: [:ex| self inform: ex messageText]]