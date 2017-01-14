memory space primitives
primitiveFetchNextMourner
	<option: #SpurObjectMemory>
	objectMemory dequeueMourner
		ifNil: [self primitiveFailFor: PrimErrNotFound]
		ifNotNil: [:mourner| self pop: 1 thenPush: mourner]