target directories
internalPluginListName
	"Answer the filename for the list of internal plugins. Since we're leaving it up to
	 platform makefiles to specify the actual named prims, just produce an example file."

	^'examplePlugins.int'