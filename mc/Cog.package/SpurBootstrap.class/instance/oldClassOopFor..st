bootstrap image
oldClassOopFor: aClass
	^oldHeap fetchPointer: ValueIndex ofObject: (literalMap at: aClass binding).