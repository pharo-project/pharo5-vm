cog jit support
mcprimFunctionForPrimitiveIndex: primIndex
	<api>
	primIndex = PrimNumberHashMultiply ifTrue:
		[^#mcprimHashMultiply:].
	self error: 'unknown mcprim'.
	^nil