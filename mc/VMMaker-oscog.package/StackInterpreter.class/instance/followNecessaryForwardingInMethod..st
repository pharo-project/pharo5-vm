lazy become
followNecessaryForwardingInMethod: methodObj
	"To avoid any chance of a forwarded object during super sends we follow the
	 methodClassAssociation.  The forwarded object send fault only copes with
	 normal sends to instances."
	| assoc classObj |
	assoc := self methodClassAssociationOf: methodObj.
	(objectMemory isForwarded: assoc) ifTrue:
		[assoc := objectMemory followForwarded: assoc.
		 self setMethodClassAssociationOf: methodObj to: assoc].
	classObj := objectMemory fetchPointer: ValueIndex ofObject: assoc.
	(objectMemory isForwarded: classObj) ifTrue:
		[classObj := objectMemory followForwarded: assoc.
		 objectMemory storePointer: ValueIndex ofObject: assoc withValue: classObj]