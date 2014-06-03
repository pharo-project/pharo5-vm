indexing primitive support
byteSizeOfInstanceOf: classObj
	| instSpec classFormat numSlots |
	classFormat := self formatOfClass: classObj.
	instSpec := self instSpecOfClassFormat: classFormat.
	(self isFixedSizePointerFormat: instSpec) ifFalse:
		[^PrimErrBadReceiver negated]. "indexable"
	numSlots := self fixedFieldsOfClassFormat: classFormat.
	^self objectBytesForSlots: numSlots