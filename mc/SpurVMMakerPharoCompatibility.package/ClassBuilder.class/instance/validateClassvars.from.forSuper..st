validation
validateClassvars: classVarArray from: oldClass forSuper: newSuper
	"Check if any of the classVars of oldClass conflict with the new superclass"
	| usedNames classVars temp |
	classVarArray isEmpty ifTrue:[^true]. "Okay"

	"Validate the class var names"
	usedNames := classVarArray asSet.
	usedNames size = classVarArray size 
		ifFalse:[	classVarArray do:[:var|
					usedNames remove: var ifAbsent:[temp := var]].
				self error: temp,' is multiply defined'. ].
	(usedNames includesAnyOf: self reservedNames) 
		ifTrue:[	self reservedNames do:[:var|
					(usedNames includes: var) ifTrue:[temp := var]].
				self error: temp,' is a reserved name'. ].
	usedNames do: [ :name |
		name isLegalInstVarName ifFalse: [ self error: name, ' is not a legal inst var name'. ] ].

	newSuper == nil ifFalse:[
		usedNames := newSuper allClassVarNames asSet.
		classVarArray do:[:iv|
			(usedNames includes: iv) ifTrue:[
				newSuper withAllSuperclassesDo:[:cl|
					(cl classVarNames includes: iv) ifTrue:[temp := cl]].
					(DuplicatedVariableError new)
                                        superclass: temp;
                                        variable: iv;
                                        signal: iv, ' is already defined in ', temp name.
				^false]]].

	classVars := classVarArray.

	oldClass == nil ifFalse:[
		usedNames := Set new: 20.
		(oldClass allSubclasses reject: #isMeta) do: [:cl | usedNames addAll: cl classVarNames].
		newSuper == nil ifFalse:[classVars := classVars, newSuper allClassVarNames asArray].
		classVars do:[:iv|
			(usedNames includes: iv) ifTrue:[
				(DuplicatedVariableError new)
                                        superclass: oldClass;
                                        variable: iv;
                                        signal: iv, ' is already defined in a subclass of ', oldClass name.
				^false]]].

	^true