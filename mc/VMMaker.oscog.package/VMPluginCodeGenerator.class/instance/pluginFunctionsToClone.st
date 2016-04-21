public
pluginFunctionsToClone
	"Answer those of the used plugin functions to clone as a sorted collection.
	 Exclude those that are static to sqVirtualMachine.c and hence always need
	 to be called through interpreterProxy.
	 Also exclude those that are generated as macros rather than function call."

	^((pluginFunctionsUsed
		reject: [:selector| self noteUsedPluginFunction: selector])
			select: [:selector| (InterpreterProxy includesSelector: selector) and: [(self selectorsThatAreGeneratedAsMacros includes: selector) not]])
				asSortedCollection