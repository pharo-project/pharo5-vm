debug support
veryDeepCopyWith: deepCopier
	"Override to short-circuit the copying of any VMPluginCodeGenerators referenced from mappedPluginEntries and
	 uniqueIndices. These can in turn hold onto Monticello state, resulting in a huge ammount of unnecessary copying."
	deepCopier references
		at: mappedPluginEntries ifAbsentPut: [mappedPluginEntries];
		at: uniqueIndices ifAbsentPut: [uniqueIndices].
	mappedPluginEntries do:
		[:tuple|
		[:sim :sel :block :argCount|
		deepCopier references at: block ifAbsentPut: [block]] valueWithArguments: tuple].
	uniqueIndices keysDo:
		[:block|
		deepCopier references at: block ifAbsentPut: [block]].
	^super veryDeepCopyWith: deepCopier