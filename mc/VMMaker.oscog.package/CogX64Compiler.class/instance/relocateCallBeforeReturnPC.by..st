inline cacheing
relocateCallBeforeReturnPC: retpc by: delta
	| distance |
	delta ~= 0 ifTrue:
		[distance :=    ((objectMemory byteAt: retpc - 1) << 24)
					+  ((objectMemory byteAt: retpc - 2) << 16)
					+  ((objectMemory byteAt: retpc - 3) << 8)
					+   (objectMemory byteAt: retpc - 4).
		 distance := distance + delta.
		 objectMemory
			byteAt: retpc - 1 put: (distance >> 24 bitAnd: 16rFF);
			byteAt: retpc - 2 put: (distance >> 16 bitAnd: 16rFF);
			byteAt: retpc - 3 put: (distance >>   8 bitAnd: 16rFF);
			byteAt: retpc - 4 put: (distance            bitAnd: 16rFF)]