plugin primitive support
methodPrimitiveIndex
	<api>
	((objectMemory addressCouldBeObj: newMethod)
	 and: [objectMemory isCompiledMethod: newMethod]) ifFalse:
		[^-1].
	^self primitiveIndexOf: newMethod