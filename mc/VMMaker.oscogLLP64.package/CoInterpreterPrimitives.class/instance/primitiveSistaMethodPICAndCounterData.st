method introspection primitives
primitiveSistaMethodPICAndCounterData
	<export: true>
	<option: #SistaCogit>
	| methodReceiver data |
	argumentCount ~= 0 ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	methodReceiver := self stackTop.
	data := 0.
	(self methodHasCogMethod: methodReceiver) ifTrue:
		[data := self picDataFor: (self cogMethodOf: methodReceiver).
		 data = -1 ifTrue:
			[^self primitiveFailFor: PrimErrNoMemory]].
	data = 0 ifTrue:
		[data := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: 0].
	self pop: 1 thenPush: data