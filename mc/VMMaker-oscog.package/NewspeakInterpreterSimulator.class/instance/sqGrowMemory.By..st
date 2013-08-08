memory access
sqGrowMemory: oldLimit By: delta

	transcript show: 'grow memory from ', oldLimit printString, ' by ', delta printString; cr.
	memory := memory , (memory class new: delta // 4).
	^ memory size * 4