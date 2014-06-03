initialize
providedPlugins
	"generate the list by asking the InterpreterPlugins"
	^ ((InterpreterPlugin allSubclasses
		select: [:cl | cl shouldBeTranslatedFor: platformName])
		collect: [:cl | cl name]) asSortedCollection