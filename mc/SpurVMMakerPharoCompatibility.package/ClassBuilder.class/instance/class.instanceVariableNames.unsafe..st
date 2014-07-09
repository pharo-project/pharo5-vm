class definition
class: oldClass instanceVariableNames: instVarString unsafe: unsafe
	"This is the basic initialization message to change the definition of
	an existing Metaclass"
	| instVars newClass needNew copyOfOldClass copyOfOldTraitComposition copyOfOldClassTraitComposition |
	environ := oldClass environment.
	instVars := instVarString subStrings: ' '.
	unsafe ifFalse:[
		"Run validation checks so we know that we have a good chance for recompilation"
		(self validateInstvars: instVars from: oldClass forSuper: oldClass superclass) ifFalse:[^nil].
		(self validateSubclassFormat: oldClass typeOfClass from: oldClass forSuper: oldClass superclass extra: instVars size) ifFalse:[^nil]].
	"See if we need a new subclass or not"
	needNew := self needsSubclassOf: oldClass superclass type: oldClass typeOfClass instanceVariables: instVars from: oldClass.
	needNew ifNil:[^nil]. "some error"
	needNew ifFalse:[^oldClass]. "no new class needed"

	"Create the new class"
	copyOfOldClass := oldClass copy.
	oldClass hasTraitComposition ifTrue: [
		copyOfOldTraitComposition := oldClass traitComposition copyTraitExpression ].
	oldClass class hasTraitComposition ifTrue: [
		copyOfOldClassTraitComposition := oldClass class traitComposition copyTraitExpression ].
		
	newClass := self 
		newSubclassOf: oldClass superclass 
		type: oldClass typeOfClass
		instanceVariables: instVars
		from: oldClass.
		
	newClass := self recompile: false from: oldClass to: newClass mutate: false.
	
	"... set trait composition..."
	copyOfOldTraitComposition ifNotNil: [
		newClass setTraitComposition: copyOfOldTraitComposition ].
	copyOfOldClassTraitComposition ifNotNil: [
		newClass class setTraitComposition: copyOfOldClassTraitComposition ].
	
	self doneCompiling: newClass.
	SystemAnnouncer uniqueInstance classDefinitionChangedFrom: copyOfOldClass to: newClass.
	^newClass