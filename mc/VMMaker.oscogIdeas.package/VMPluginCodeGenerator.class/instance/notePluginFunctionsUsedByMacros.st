public
notePluginFunctionsUsedByMacros
	"Declare the plugin functions that are used by macros."
	#(
		isKindOfInteger: #(classLargeNegativeInteger classLargePositiveInteger fetchClassOf: isIntegerObject: )
		isIntegerObject:  #()
		isLargeIntegerObject: #(classLargeNegativeInteger classLargePositiveInteger fetchClassOf: )
		isLargeNegativeIntegerObject: 	#(classLargeNegativeInteger fetchClassOf: )
		isLargePositiveIntegerObject: 	#(classLargePositiveInteger fetchClassOf: ))
			pairsDo: [:macro :funcs |
				(pluginFunctionsUsed includes: macro) ifTrue: [pluginFunctionsUsed addAll: funcs]].