simulation
newFor: anUnsimulatedInterpreterPluginClass
	| simulatorClass |
	simulatorClass := anUnsimulatedInterpreterPluginClass subclasses
						detect: [:sc| sc name endsWith: 'Simulator']
						ifNone: [anUnsimulatedInterpreterPluginClass].
	^self new
		actualPlugin: simulatorClass new signatureClass: anUnsimulatedInterpreterPluginClass;
		yourself