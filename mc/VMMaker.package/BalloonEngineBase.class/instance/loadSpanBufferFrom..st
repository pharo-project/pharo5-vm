loading state
loadSpanBufferFrom: spanOop
	"Load the span buffer from the given oop.
	 Answer 0 on success or a non-zero failure code on failure."
	<inline: false>
	(interpreterProxy fetchClassOf: spanOop) = (interpreterProxy classBitmap) ifFalse:[^GEFClassMismatch].
	spanBuffer := interpreterProxy firstIndexableField: spanOop.
	"Leave last entry unused to avoid complications"
	self spanSizePut: (interpreterProxy slotSizeOf: spanOop) - 1.
	^0