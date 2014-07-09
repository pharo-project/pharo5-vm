class definition
silentlyMoveInstVarNamed: instVarName from: srcClass to: dstClass after: prevInstVarName
	"Move the instvar from srcClass to dstClass.
	Do not perform any checks."
	| srcVars dstVars dstIndex newClass copyOfSrcClass copyOfDstClass copyOfOldTraitComposition copyOfOldClassTraitComposition |
	copyOfSrcClass := srcClass copy.
	copyOfDstClass := dstClass copy.
	
	srcVars := srcClass instVarNames copyWithout: instVarName.
	srcClass == dstClass
		ifTrue:[dstVars := srcVars]
		ifFalse:[dstVars := dstClass instVarNames].
	dstIndex := dstVars indexOf: prevInstVarName.
	dstVars := (dstVars copyFrom: 1 to: dstIndex),
				(Array with: instVarName),
				(dstVars copyFrom: dstIndex+1 to: dstVars size).
	instVarMap at: srcClass name put: srcVars.
	instVarMap at: dstClass name put: dstVars.
	(srcClass inheritsFrom: dstClass) ifTrue:[
		copyOfOldTraitComposition := copyOfOldClassTraitComposition := nil.
		dstClass hasTraitComposition ifTrue: [
			copyOfOldTraitComposition := dstClass traitComposition copyTraitExpression ].
		dstClass class hasTraitComposition ifTrue: [
			copyOfOldClassTraitComposition := dstClass class traitComposition copyTraitExpression ].
		
		newClass := self reshapeClass: dstClass toSuper: dstClass superclass.
		self recompile: false from: dstClass to: newClass mutate: true.
		
		copyOfOldTraitComposition ifNotNil: [
			newClass setTraitComposition: copyOfOldTraitComposition ].
		copyOfOldClassTraitComposition ifNotNil: [
			newClass class setTraitComposition: copyOfOldClassTraitComposition ].
	] ifFalse:[
		newClass := self reshapeClass: srcClass toSuper: srcClass superclass.
		(dstClass inheritsFrom: srcClass) ifFalse:[ "Disjunct hierarchies"
			srcClass == dstClass ifFalse:[
				newClass := self reshapeClass: dstClass toSuper: dstClass superclass.
				self recompile: false from: dstClass to: newClass mutate: true.
			].
			newClass := self reshapeClass: srcClass toSuper: srcClass superclass.
		].
		self recompile: false from: srcClass to: newClass mutate: true.
	].
	self doneCompiling: srcClass.
	self doneCompiling: dstClass.
	SystemAnnouncer uniqueInstance classDefinitionChangedFrom: copyOfSrcClass to: srcClass.
	SystemAnnouncer uniqueInstance classDefinitionChangedFrom: copyOfDstClass to: dstClass.