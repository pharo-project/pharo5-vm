allocation
maybeFillWithAllocationCheckFillerFrom: start to: end
	"Fill free memory with a bit pattern for checking if the last object has been overwritten."
	<inline: true>
	<var: 'start' type: #usqInt>
	<var: 'end' type: #usqInt>
	<var: 'i' type: #usqInt>
	AllocationCheckFiller ~= 0 ifTrue:
		[start to: end by: BytesPerWord do:
			[:i|
			self longAt: i put: (AllocationCheckFiller = 16rADD4E55
									ifTrue: [i]
									ifFalse: [AllocationCheckFiller])]]