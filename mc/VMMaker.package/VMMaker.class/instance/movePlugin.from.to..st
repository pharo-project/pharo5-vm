UI access
movePlugin: pluginName from: srcListName to: dstListName
	"the VMMakerTool UI has been used to drag a plugin from one list to 
	another "
	"we need to do some tests - 
	are the lists actually ours? 
	is the plugin ours? 
	is the destination list one where we must check the plugin for 
	acceptability? return true if all is ok, false otherwise"
	| dstList srcList |
	dstList := self listOfName: dstListName.
	srcList := self listOfName: srcListName.
	dstList == allPlugins
		ifTrue: [dstList
				add: (srcList remove: pluginName)]
		ifFalse: ["the dest must be internal or external, so check the plugin for 
			acceptability "
			(self canSupportPlugin: pluginName)
				ifTrue: [dstList
						add: (srcList remove: pluginName)]]