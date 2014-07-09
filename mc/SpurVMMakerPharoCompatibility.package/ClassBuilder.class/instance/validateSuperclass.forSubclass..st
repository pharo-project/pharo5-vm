validation
validateSuperclass: aSuperClass forSubclass: aClass
	"Check if it is okay to use aSuperClass as the superclass of aClass"
	aClass == nil ifTrue:["New class"
		(aSuperClass == nil or:[aSuperClass isBehavior and:[aSuperClass isMeta not]])
			ifFalse:[self error: aSuperClass name,' is not a valid superclass'.
					^false].
		^true].
	aSuperClass == aClass superclass ifTrue:[^true]. "No change"
	(aClass isMeta) "Not permitted - meta class hierarchy is derived from class hierarchy"
		ifTrue:[^self error: aClass name, ' must inherit from ', aClass superclass name].
	"Check for circular references"
	(aSuperClass ~~ nil and:[aSuperClass == aClass or:[aSuperClass inheritsFrom: aClass]])
		ifTrue:[self error: aSuperClass name,' inherits from ', aClass name.
				^false].
	^true