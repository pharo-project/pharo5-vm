garbage collection
storeClassRef: classObj inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	objectMemory longAt: address - objectMemory bytesPerOop put: classObj