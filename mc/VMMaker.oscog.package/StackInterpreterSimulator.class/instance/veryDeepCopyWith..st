debug support
veryDeepCopyWith: deepCopier
	"Override to short-circuit the copying of any VMPluginCodeGenerators referenced from mappedPluginEntries.
	 These can in turn hold onto Monticello state, resulting in a huge ammount of unnecessary copying."
	"deepCopier references
		at: mappedPluginEntries ifAbsentPut: [mappedPluginEntries].
	mappedPluginEntries do:
		[:tuple|
		[:sim :sel :block :argCount|
		deepCopier references at: block ifAbsentPut: [block]] valueWithArguments: tuple]."
	^super veryDeepCopyWith: deepCopier