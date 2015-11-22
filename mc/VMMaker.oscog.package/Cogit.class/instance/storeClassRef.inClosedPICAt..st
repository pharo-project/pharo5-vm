in-line cacheing
storeClassRef: classObj inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	"If inline cache tags are not objects they will be 32-bit values."
	objectRepresentation inlineCacheTagsMayBeObjects
		ifTrue: [backEnd storeLiteral: classObj beforeFollowingAddress: address]
		ifFalse: [backEnd storeLiteral32: classObj beforeFollowingAddress: address]