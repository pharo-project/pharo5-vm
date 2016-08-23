process primitives
primitiveCollectCogCodeConstituents
	"Answer the contents of the code zone as an array of pair-wise element, address in ascending address order.
	 Answer a string for a runtime routine or abstract label (beginning, end, etc), a CompiledMethod for a CMMethod,
	 or a selector (presumably a Symbol) for a PIC."
	| constituents |
	constituents := cogit cogCodeConstituents.
	constituents ifNil:
		[^self primitiveFailFor: PrimErrNoMemory].
	self pop: 1 thenPush: constituents