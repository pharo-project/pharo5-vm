accessing
functionPointerForCompiledMethod: methodOop primitiveIndex: primIndex
	^([coInterpreter functionPointerForCompiledMethod: methodOop primitiveIndex: primIndex]
			on: MessageNotUnderstood
			do: [:ex|
				#someExternalPrimitive]) ifNotNil:
		[:symbol|
		self addressForLabel: symbol]