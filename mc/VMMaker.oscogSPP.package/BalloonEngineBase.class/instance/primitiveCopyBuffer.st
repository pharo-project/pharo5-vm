primitives-other
primitiveCopyBuffer
	| failCode buf1 buf2 diff src dst |
	<export: true>
	<inline: false>
	<var: #src type:'int * '>
	<var: #dst type:'int * '>

	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	buf2 := interpreterProxy stackValue: 0.
	buf1 := interpreterProxy stackValue: 1.
	"Make sure the old buffer is properly initialized"
	(failCode := self loadWorkBufferFrom: buf1) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failCode].
	"Make sure the buffers are of the same type"
	(interpreterProxy fetchClassOf: buf1) = (interpreterProxy fetchClassOf: buf2)
		ifFalse:[^interpreterProxy primitiveFailFor: GEFClassMismatch].
	"Make sure buf2 is at least of the size of buf1"
	diff := (interpreterProxy slotSizeOf: buf2) - (interpreterProxy slotSizeOf: buf1).
	diff < 0 ifTrue:[^interpreterProxy primitiveFailFor: GEFSizeMismatch].

	"Okay - ready for copying. First of all just copy the contents up to wbTop"
	src := workBuffer.
	dst := interpreterProxy firstIndexableField: buf2.
	0 to: self wbTopGet-1 do:[:i|
		dst at: i put: (src at: i).
	].
	"Adjust wbSize and wbTop in the new buffer"
	dst at: GWBufferTop put: self wbTopGet + diff.
	dst at: GWSize put: self wbSizeGet + diff.
	"Now copy the entries from wbTop to wbSize"
	src := src + self wbTopGet.
	dst := dst + self wbTopGet + diff.
	0 to: (self wbSizeGet - self wbTopGet - 1) do:[:i|
		dst at: i put: (src at: i).
	].
	"Okay, done. Check the new buffer by loading the state from it"
	(failCode := self loadWorkBufferFrom: buf2) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failCode].
	interpreterProxy pop: 2. "Leave rcvr on stack"
