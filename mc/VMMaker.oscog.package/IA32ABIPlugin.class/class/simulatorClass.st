simulation only
simulatorClass
	^NewspeakVM ifFalse: [IA32ABIPluginSimulator]