util
createLargeIntegerNeg: neg byteLength: byteLength
	<inline: true>
	^interpreterProxy
		instantiateClass: (neg
				ifTrue: [interpreterProxy classLargeNegativeInteger]
				ifFalse: [interpreterProxy classLargePositiveInteger])
		indexableSize: byteLength