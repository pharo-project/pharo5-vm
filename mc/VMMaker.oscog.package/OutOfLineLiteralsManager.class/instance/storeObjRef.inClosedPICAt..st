garbage collection
storeObjRef: literal inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	objectMemory longAt: address put: literal