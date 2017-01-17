compiled methods
saneMethodClassAssociationIn: methodObj numLiterals: numLiterals
	| shouldBeAssoc |
	shouldBeAssoc := self literal: numLiterals - 1 ofMethod: methodObj.
	(objectMemory isForwarded: shouldBeAssoc) ifTrue:
		[shouldBeAssoc := objectMemory followForwarded: shouldBeAssoc].
	^(objectMemory isPointers: shouldBeAssoc)
	 and: [(objectMemory numSlotsOf: shouldBeAssoc) > ValueIndex
	 and: [self addressCouldBeClassObj: (objectMemory noFixupFollowField: ValueIndex ofObject: shouldBeAssoc)]]