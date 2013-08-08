primitives
primitiveResolverStatus

	| status |
	self primitive: 'primitiveResolverStatus'.
	status := self sqResolverStatus.
	^status asSmallIntegerObj