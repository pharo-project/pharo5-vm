primitives
primitiveResolverAddressLookupResult
	| sz s |
	self primitive: 'primitiveResolverAddressLookupResult'.
	sz := self sqResolverAddrLookupResultSize.

	interpreterProxy failed
		ifFalse: [s := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: sz.
			self sqResolverAddrLookup: s asCharPtr Result: sz].
	^ s