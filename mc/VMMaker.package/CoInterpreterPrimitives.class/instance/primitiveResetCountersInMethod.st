method introspection primitives
primitiveResetCountersInMethod
	<export: true>
	<option: #SistaStackToRegisterMappingCogit>
	| methodReceiver |
	argumentCount ~= 0 ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	methodReceiver := self stackTop.
	(self methodHasCogMethod: methodReceiver) ifTrue:
		[cogit resetCountersIn: (self cogMethodOf: methodReceiver)]