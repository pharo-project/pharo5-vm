class definition
newSubclassOf: newSuper type: type instanceVariables: instVars from: oldClass
	"Create a new subclass of the given superclass with the given specification."
	| newFormat newClass |
	"Compute the format of the new class"
	newFormat := 
		self computeFormat: type 
			instSize: instVars size 
			forSuper: newSuper 
			ccIndex: (oldClass ifNil:[0] ifNotNil:[oldClass indexIfCompact]).

	newFormat == nil ifTrue:[^nil].

	(oldClass == nil or:[oldClass isMeta not]) 
		ifTrue:[newClass := self privateNewSubclassOf: newSuper from: oldClass]
		ifFalse:[newClass := oldClass shallowCopy].

	newClass 
		superclass: newSuper
		methodDictionary: MethodDictionary new
		format: newFormat;
		setInstVarNames: instVars.

	oldClass ifNotNil:[
		newClass organization: oldClass organization.
		newClass isMeta not ifTrue: [ newClass environment at: newClass name put: newClass ].
		"Recompile the new class"
		oldClass hasMethods 
			ifTrue:[newClass compileAllFrom: oldClass].		
		self recordClass: oldClass replacedBy: newClass.
	].

	(oldClass == nil or:[newClass isObsolete not]) 
		ifTrue:[newSuper addSubclass: newClass]
		ifFalse:[newSuper addObsoleteSubclass: newClass].

	^newClass