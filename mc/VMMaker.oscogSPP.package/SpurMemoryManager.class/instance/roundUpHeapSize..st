snapshot
roundUpHeapSize: heapSize
	<var: 'heapSize' type: #usqInt>
	| bit |
	bit := heapSize highBit - 1 * 3 // 4.
	^(heapSize anyMask: (1 << bit - 1))
		ifTrue: [(heapSize bitClear: (1 << bit - 1)) + (1 << bit)]
		ifFalse: [heapSize]