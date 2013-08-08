memory access
sqGrowMemory: oldLimit By: delta

	transcript show: 'grow memory from ', oldLimit printString, ' by ', delta printString; cr.
	objectMemory memory: objectMemory memory , (objectMemory memory class new: delta // 4).
	^ objectMemory memory size * 4