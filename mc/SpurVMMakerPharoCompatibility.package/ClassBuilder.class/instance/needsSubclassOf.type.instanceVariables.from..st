class definition
needsSubclassOf: newSuper type: type instanceVariables: instVars from: oldClass
	"Answer whether we need a new subclass to conform to the requested changes"
	| newFormat |
	"Compute the format of the new class"
	newFormat := 
		self computeFormat: type 
			instSize: instVars size 
			forSuper: newSuper 
			ccIndex: (oldClass ifNil:[0] ifNotNil:[oldClass indexIfCompact]).
	newFormat == nil ifTrue:[^nil].

	"Check if we really need a new subclass"
	oldClass ifNil:[^true]. "yes, it's a new class"
	newSuper == oldClass superclass ifFalse:[^true]. "yes, it's a superclass change"
	newFormat = oldClass format ifFalse:[^true]. "yes, it's a format change"
	instVars = oldClass instVarNames ifFalse:[^true]. "yes, it's an iVar change"

	^false
