public
pluginFunctionsToClone
	"Answer those of the used plugin functions to clone as a sorted collection.
	 Exclude those that are static to sqVirtualMachine.c and hence always need
	 to be called through interpreterProxy."

	^((pluginFunctionsUsed
		reject: [:selector| self noteUsedPluginFunction: selector])
			select: [:selector| InterpreterProxy includesSelector: selector])
				asSortedCollection