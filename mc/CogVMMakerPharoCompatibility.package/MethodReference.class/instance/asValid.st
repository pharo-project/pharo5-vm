converting
asValid
	"Sometimes persistent MethodReferences may become stale after a refactoring which moved some methods to a superclass.  This method answers the new valid MethodReference if that happened."
	^ self isValid
		ifTrue: [ self ]
		ifFalse:
			[ | cm |
			cm := self actualClass lookupSelector: self selector.
			cm ifNotNil: [ cm methodReference ] ]