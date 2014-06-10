allocation
initSpaceForAllocationCheck: aNewSpace
	<var: 'aNewSpace' type: #'SpurNewSpaceSpace *'>
	memory ifNotNil:
		[CheckObjectOverwrite ifTrue:
			[aNewSpace start
				to: aNewSpace limit - 1
				by: self wordSize
				do: [:p| self longAt: p put: p]]]