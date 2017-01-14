indexing primitive support
byteSizeOfInstanceOf: classObj errInto: errBlock
	| instSpec classFormat numSlots |
	classFormat := self formatOfClass: classObj.
	instSpec := self instSpecOfClassFormat: classFormat.
	(self isFixedSizePointerFormat: instSpec) ifFalse:
		[^errBlock value: PrimErrBadReceiver]. "indexable"
	numSlots := self fixedFieldsOfClassFormat: classFormat.
	^self objectBytesForSlots: numSlots