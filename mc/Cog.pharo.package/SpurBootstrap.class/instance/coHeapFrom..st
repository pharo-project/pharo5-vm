testing
coHeapFrom: aSpur32BitMMLESimulator
	| coHeap |
	coHeap := Spur32BitMMLECoSimulator new.
	aSpur32BitMMLESimulator class allInstVarNames do:
		[:ivn|
		coHeap instVarNamed: ivn put: (aSpur32BitMMLESimulator instVarNamed: ivn)].
	coHeap scavenger instVarNamed: 'manager' put: coHeap.
	^coHeap