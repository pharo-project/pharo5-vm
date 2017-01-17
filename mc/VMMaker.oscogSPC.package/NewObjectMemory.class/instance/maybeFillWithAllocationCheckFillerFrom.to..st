allocation
maybeFillWithAllocationCheckFillerFrom: start to: end
	"Fill free memory with a bit pattern for checking if the last object has been overwritten."
	<inline: true>
	<var: 'start' type: #usqInt>
	<var: 'end' type: #usqInt>
	<var: 'p' type: #usqInt>
	self checkAllocFiller ifTrue:
		[start to: end by: self wordSize do:
			[:p| self longAt: p put: p]]