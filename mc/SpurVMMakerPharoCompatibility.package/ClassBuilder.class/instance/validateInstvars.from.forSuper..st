validation
validateInstvars: instVarArray from: oldClass forSuper: newSuper
	"Check if any of the instVars of oldClass conflict with the new superclass"
	| instVars usedNames temp |
	instVarArray isEmpty ifTrue:[^true]. "Okay"
	newSuper allowsSubInstVars ifFalse: [
		self error: newSuper printString, ' does not allow subclass inst vars. See allowsSubInstVars.'. ].

	"Validate the inst var names"
	usedNames := instVarArray asSet.
	usedNames size = instVarArray size 
		ifFalse:[	instVarArray do:[:var|
					usedNames remove: var ifAbsent:[temp := var]].
				self error: temp,' is multiply defined'. ].
	(usedNames includesAnyOf: self reservedNames) 
		ifTrue:[	self reservedNames do:[:var|
					(usedNames includes: var) ifTrue:[temp := var]].
				self error: temp,' is a reserved name'. ].
	usedNames do: [ :name |
		name isLegalInstVarName ifFalse: [ self error: name, ' is not a legal inst var name'. ] ].
	^true