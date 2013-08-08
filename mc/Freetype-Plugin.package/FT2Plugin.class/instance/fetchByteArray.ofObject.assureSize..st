private
fetchByteArray: fieldIndex ofObject: objectPointer assureSize: aSize
	| array |
	self returnTypeC: 'char *'.
	
	array := interpreterProxy fetchPointer: fieldIndex ofObject: objectPointer.
	((interpreterProxy isBytes: array) and:[(interpreterProxy slotSizeOf: array) = aSize]) 
		ifTrue: [^interpreterProxy arrayValueOf: array].
	^nil
	
