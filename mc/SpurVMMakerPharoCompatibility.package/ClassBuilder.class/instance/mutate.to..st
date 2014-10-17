class mutation
mutate: oldClass to: newClass
	"Mutate the old class and subclasses into newClass and subclasses.
	Note: This method is slightly different from: #mutate:toSuper: since
	here we are at the root of reshaping and have two distinct roots."

	| copyOfOldTraitComposition copyOfOldClassTraitComposition |
	self showProgressFor: oldClass.
	"Convert the subclasses"
	oldClass subclasses do: [:oldSubclass | | newSubclass |
		copyOfOldTraitComposition := copyOfOldClassTraitComposition := nil.
		oldSubclass hasTraitComposition ifTrue: [
			copyOfOldTraitComposition := oldSubclass traitComposition copyTraitExpression ].
		oldSubclass class hasTraitComposition ifTrue: [
			copyOfOldClassTraitComposition := oldSubclass class traitComposition copyTraitExpression ].
	
		newSubclass := self reshapeClass: oldSubclass toSuper: newClass.
		self mutate: oldSubclass to: newSubclass.
			
		copyOfOldTraitComposition ifNotNil: [
			newSubclass setTraitComposition: copyOfOldTraitComposition ].
		copyOfOldClassTraitComposition ifNotNil: [
			newSubclass class setTraitComposition: copyOfOldClassTraitComposition ].
	].
	"And any obsolete ones"
	oldClass obsoleteSubclasses do: [:oldSubclass | | newSubclass |
		oldSubclass ifNotNil: [
			copyOfOldTraitComposition := copyOfOldClassTraitComposition := nil.
			oldSubclass hasTraitComposition ifTrue: [
				copyOfOldTraitComposition := oldSubclass traitComposition copyTraitExpression ].
			oldSubclass class hasTraitComposition ifTrue: [
				copyOfOldClassTraitComposition := oldSubclass class traitComposition copyTraitExpression ].
			
			newSubclass := self reshapeClass: oldSubclass toSuper: newClass.
			self mutate: oldSubclass to: newSubclass.
			
			copyOfOldTraitComposition ifNotNil: [
				newSubclass setTraitComposition: copyOfOldTraitComposition ].
			copyOfOldClassTraitComposition ifNotNil: [
				newSubclass class setTraitComposition: copyOfOldClassTraitComposition ].
		].
	].
	self update: oldClass to: newClass.
	^newClass