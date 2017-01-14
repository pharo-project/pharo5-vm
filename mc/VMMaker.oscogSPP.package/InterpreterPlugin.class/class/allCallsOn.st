accessing
allCallsOn
	"Answer a SortedCollection of all the methods that refer to me. Most classes simply defer to SystemDictionary>allCallsOn: but some have special requirements - plugins may have a module name that does not match the class name"

	self theNonMetaClass name ~= self moduleName asSymbol
		ifTrue:[^super allCallsOn, (self systemNavigation allCallsOn: self moduleName asSymbol)]
		ifFalse:[^super allCallsOn]