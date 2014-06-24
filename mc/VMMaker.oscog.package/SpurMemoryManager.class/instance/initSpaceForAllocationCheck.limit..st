allocation
initSpaceForAllocationCheck: aNewSpace limit: limit
	<var: 'aNewSpace' type: #'SpurNewSpaceSpace *'>
	<var: 'limit' type: #usqInt>
	memory ifNotNil:
		[self checkAllocFiller ifTrue:
			[aNewSpace start
				to: limit - 1
				by: self wordSize
				do: [:p| self longAt: p put: p]]]