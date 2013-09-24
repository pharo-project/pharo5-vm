allocation
initSpaceForAllocationCheck: aNewSpace
	CheckObjectOverwrite ifTrue:
		[aNewSpace start
			to: aNewSpace limit - 1
			by: self wordSize
			do: [:p| self longAt: p put: p]]