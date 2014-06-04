rump c stack
rumpCStackAddress
	| alignment alignedHeapBase |
	alignment := 64. "byte alignment for stack frames; IA32 requires 16 bytes."
	alignedHeapBase := heapBase bitAnd: alignment negated.
	^alignedHeapBase = heapBase
		ifTrue: [heapBase - alignment]
		ifFalse: [alignedHeapBase]