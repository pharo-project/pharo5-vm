lazy become
actuallyFollowNecessaryForwardingInMethod: methodObj literalCount: litCount
	"To avoid any chance of a forwarded object during super sends we follow the
	 methodClassAssociation.  The forwarded object send fault only copes with
	 normal sends to instances.  Inline methodClassAssociation access for speed."
	| assoc classObj |
	<option: #SpurObjectMemory>
	<inline: true>
	assoc := self literal: litCount - 1 ofMethod: methodObj.
	(objectMemory isForwarded: assoc) ifTrue:
		[assoc := objectMemory followForwarded: assoc.
		 objectMemory
			storePointer: litCount + LiteralStart - 1
			ofObject: methodObj
			withValue: assoc].
	(objectMemory numSlotsOf: assoc) >= (ValueIndex + 1) ifTrue:
		[classObj := objectMemory fetchPointer: ValueIndex ofObject: assoc.
		 (objectMemory isForwarded: classObj) ifTrue:
			[classObj := objectMemory followForwarded: assoc.
			 objectMemory storePointer: ValueIndex ofObject: assoc withValue: classObj]]