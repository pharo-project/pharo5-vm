debug support
veryDeepCopyWith: deepCopier
	"Override to short-circuit the copying of any VMPluginCodeGenerators referenced from mappedPluginEntries.
	 These can in turn hold onto Monticello state, resulting in a huge ammount of unnecessary copying."
	self objectMemory hasSpurMemoryManagerAPI ifTrue: 
		[deepCopier references
			at: mappedPluginEntries ifAbsentPut: [mappedPluginEntries].
		mappedPluginEntries do:
			[:tuple| | block |
			block := tuple third.
			deepCopier references at: block ifAbsentPut: [block]]].
	^super veryDeepCopyWith: deepCopier