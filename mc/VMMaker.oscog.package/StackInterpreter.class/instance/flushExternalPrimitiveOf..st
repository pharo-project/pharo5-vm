plugin primitive support
flushExternalPrimitiveOf: methodObj
	"methodObj is a CompiledMethod. If it contains an external primitive,
	 flush the function address and session ID of the CM.  Answer the prim
	 index for the benefit of subclass overrides."
	<inline: false>
	| header primIdx lit |
	header := objectMemory methodHeaderOf: methodObj.
	primIdx := self primitiveIndexOfMethod: methodObj header: header.
	(primIdx = PrimitiveExternalCallIndex
	 and: [(objectMemory literalCountOfMethodHeader: header) > 0]) ifTrue: "If not, something's broken"
		[lit := self literal: 0 ofMethod: methodObj.
		((objectMemory isArray: lit) and: [(objectMemory numSlotsOf: lit) = 4]) ifTrue: "If not, something's broken"
			[objectMemory
				storePointerUnchecked: 2 ofObject: lit withValue: ConstZero;
				storePointerUnchecked: 3 ofObject: lit withValue: ConstZero]].
	^primIdx