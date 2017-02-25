fills-bitmaps
loadBitsFrom: bmFill
	"Note: Assumes that the contents of formArray has been checked before"
	| xIndex formOop bitsOop bitsLen |
	<returnTypeC:'int *'>
	xIndex := self objectIndexOf: bmFill.
	xIndex > (interpreterProxy slotSizeOf: formArray) ifTrue:[^nil].
	formOop := interpreterProxy fetchPointer: xIndex ofObject: formArray.
	bitsOop := interpreterProxy fetchPointer: 0 ofObject: formOop.
	bitsLen := interpreterProxy slotSizeOf: bitsOop.
	bitsLen = (self bitmapSizeOf: bmFill) ifFalse:[^nil].
	^interpreterProxy firstIndexableField: bitsOop