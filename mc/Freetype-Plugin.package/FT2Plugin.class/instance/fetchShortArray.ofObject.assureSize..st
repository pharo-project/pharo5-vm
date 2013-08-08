private
fetchShortArray: fieldIndex ofObject: objectPointer assureSize: aSize
	| array |
	self returnTypeC: 'short*'.
	
	array := interpreterProxy fetchPointer: fieldIndex ofObject: objectPointer.
	((interpreterProxy isWords: array) and:[(interpreterProxy slotSizeOf: array) = ((aSize + 1) // 2)]) 
		ifTrue: [^interpreterProxy arrayValueOf: array].
	^nil.
