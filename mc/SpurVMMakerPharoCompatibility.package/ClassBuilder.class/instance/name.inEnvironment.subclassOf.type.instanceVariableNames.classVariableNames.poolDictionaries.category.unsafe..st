class definition
name: className inEnvironment: env subclassOf: newSuper type: type instanceVariableNames: instVarString classVariableNames: classVarString poolDictionaries: poolString category: category unsafe: unsafe
	"Define a new class in the given environment.
	If unsafe is true do not run any validation checks.
	This facility is provided to implement important system changes."

	| oldClass instVars classVars copyOfOldClass copyOfOldTraitComposition copyOfOldClassTraitComposition newClass |
	environ := env.
	instVars := instVarString subStrings: ' '.
	classVars := (classVarString subStrings: ' ') collect: [ :x | x asSymbol ].	"Validate the proposed name"
	unsafe
		ifFalse: [ 
			(self validateClassName: className)
				ifFalse: [ ^ nil ] ].
	oldClass := env at: className ifAbsent: [ nil ].
	oldClass isBehavior
		ifFalse: [ oldClass := nil ]
		ifTrue: [ 
			copyOfOldClass := oldClass copy.
			copyOfOldClass superclass addSubclass: copyOfOldClass.
			copyOfOldClass
				ifNotNil: [ 
					oldClass hasTraitComposition
						ifTrue: [ copyOfOldTraitComposition := oldClass traitComposition copyTraitExpression ].
					oldClass class hasTraitComposition
						ifTrue: [ copyOfOldClassTraitComposition := oldClass class traitComposition copyTraitExpression ] ] ].	"Already checked in #validateClassName:"
	[ 
	| newCategory oldCategory needNew force organization |
	unsafe
		ifFalse: [ 
			"Run validation checks so we know that we have a good chance for recompilation"
			(self validateSuperclass: newSuper forSubclass: oldClass)
				ifFalse: [ ^ nil ].
			(self validateInstvars: instVars from: oldClass forSuper: newSuper)
				ifFalse: [ ^ nil ].
			(self validateClassvars: classVars from: oldClass forSuper: newSuper)
				ifFalse: [ ^ nil ].
			(self
				validateSubclassFormat: type
				from: oldClass
				forSuper: newSuper
				extra: instVars size)
				ifFalse: [ ^ nil ] ].	"See if we need a new subclass"
	needNew := self
		needsSubclassOf: newSuper
		type: type
		instanceVariables: instVars
		from: oldClass.
	needNew == nil
		ifTrue: [ ^ nil ].	"some error"
	(needNew and: [ unsafe not ])
		ifTrue: [ 
			"Make sure we don't redefine any dangerous classes"
			(self tooDangerousClasses includes: oldClass name)
				ifTrue: [ self error: oldClass name , ' cannot be changed' ].	"Check if the receiver should not be redefined"
			(oldClass ~~ nil and: [ oldClass shouldNotBeRedefined ])
				ifTrue: [ self notify: oldClass name asText allBold , ' should not be redefined. \Proceed to store over it.' withCRs ] ].
	needNew
		ifTrue: [ 
			"Create the new class"
			newClass := self
				newSubclassOf: newSuper
				type: type
				instanceVariables: instVars
				from: oldClass.
			newClass == nil
				ifTrue: [ ^ nil ].	"Some error"
			newClass setName: className ]
		ifFalse: [ 
			"Reuse the old class"
			newClass := oldClass ].	"Install the class variables and pool dictionaries... "
	force := (newClass declare: classVarString) | (newClass sharing: poolString).	"... classify ..."
	newCategory := category asSymbol.
	organization := environ ifNotNil: [ environ organization ].
	oldClass ifNotNil: [ oldCategory := (organization categoryOfElement: oldClass name) asSymbol ].
	organization classify: newClass name under: newCategory.
	newClass environment: environ.	"... recompile ..."
	newClass := self
		recompile: force
		from: oldClass
		to: newClass
		mutate: false.	"... export if not yet done ..."
	(environ at: newClass name ifAbsent: [ nil ]) == newClass
		ifFalse: [ 
			environ at: newClass name put: newClass.
			Smalltalk globals flushClassNameCache ].	"... set trait composition..."
	copyOfOldTraitComposition ifNotNil: [ newClass setTraitComposition: copyOfOldTraitComposition ].
	copyOfOldClassTraitComposition ifNotNil: [ newClass class setTraitComposition: copyOfOldClassTraitComposition ].
	newClass doneCompiling.	"... notify interested clients ..."
	oldClass ifNil: [ 
			SystemAnnouncer uniqueInstance classAdded: newClass inCategory: newCategory.
			^ newClass ].
	newCategory ~= oldCategory
		ifTrue: [ SystemAnnouncer uniqueInstance class: newClass recategorizedFrom: oldCategory to: category ]
		ifFalse: [ SystemAnnouncer uniqueInstance classDefinitionChangedFrom: copyOfOldClass to: newClass ] ]
		ensure: [ 
			copyOfOldClass ifNotNil: [ copyOfOldClass superclass removeSubclass: copyOfOldClass ].
			Behavior flushObsoleteSubclasses ].
	^ newClass