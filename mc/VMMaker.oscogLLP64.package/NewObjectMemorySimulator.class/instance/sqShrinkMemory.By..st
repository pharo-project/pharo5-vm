memory access
sqShrinkMemory: oldLimit By: delta
	coInterpreter transcript show: 'shrink memory from ', oldLimit printString, ' by ', delta printString, ' remember it doesn''t actually shrink in simulation'; cr.

	^oldLimit