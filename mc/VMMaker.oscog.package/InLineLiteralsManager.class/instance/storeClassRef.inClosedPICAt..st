garbage collection
storeClassRef: classObj inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	backEnd storeLiteral: classObj beforeFollowingAddress: address - backEnd loadLiteralByteSize