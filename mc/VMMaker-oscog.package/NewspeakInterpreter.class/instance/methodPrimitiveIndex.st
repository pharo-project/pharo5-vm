plugin primitive support
methodPrimitiveIndex
	<api>
	((self addressCouldBeObj: newMethod)
	 and: [self isCompiledMethod: newMethod]) ifFalse:
		[^-1].
	^self primitiveIndexOf: newMethod