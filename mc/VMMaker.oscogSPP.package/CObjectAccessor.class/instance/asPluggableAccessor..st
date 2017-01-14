converting
asPluggableAccessor: accessorArray
	^((CPluggableAccessor on: object) += offset)
		atBlock: accessorArray first
		atPutBlock: accessorArray last