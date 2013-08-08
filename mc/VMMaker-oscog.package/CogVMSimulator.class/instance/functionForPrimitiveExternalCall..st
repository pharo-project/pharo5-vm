plugin primitives
functionForPrimitiveExternalCall: methodObj
	"Override to jump through the plugin simulation hoops."
	| symbolOrIndex |
	symbolOrIndex := super functionForPrimitiveExternalCall: methodObj.
	^symbolOrIndex isSymbol
		ifTrue: [symbolOrIndex]
		ifFalse: [(self pluginEntryFor: symbolOrIndex) at: 3]