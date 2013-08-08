private
fetchWordArray: fieldIndex ofObject: objectPointer assureSize: aSize
	| array |
	self returnTypeC: 'long *'.
	
	array := interpreterProxy fetchPointer: fieldIndex ofObject: objectPointer.
	((interpreterProxy isWords: array) and:[(interpreterProxy slotSizeOf: array) = aSize]) 
		ifTrue: [^interpreterProxy arrayValueOf: array].
	^nil.
