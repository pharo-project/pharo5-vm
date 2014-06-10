loading state
loadWorkBufferFrom: wbOop
	"Load the working buffer from the given oop"
	<inline: false>
	(interpreterProxy isImmediate: wbOop) ifTrue:[^GEFWorkBufferIsInteger].
	(interpreterProxy isWords: wbOop) ifFalse:[^GEFWorkBufferIsPointers].
	(interpreterProxy slotSizeOf: wbOop) < GWMinimalSize ifTrue:[^GEFWorkBufferTooSmall].
	self workBufferPut: wbOop.
	self magicNumberGet = GWMagicNumber ifFalse:[^GEFWorkBufferBadMagic].
	"Sanity checks"
	(self wbSizeGet = (interpreterProxy slotSizeOf: wbOop)) ifFalse:[^GEFWorkBufferWrongSize].
	self objStartGet = GWHeaderSize ifFalse:[^GEFWorkBufferStartWrong].

	"Load buffers"
	objBuffer := workBuffer + self objStartGet.
	getBuffer := objBuffer + self objUsedGet.
	aetBuffer := getBuffer + self getUsedGet.

	"Make sure we don't exceed the work buffer"
	GWHeaderSize + self objUsedGet + self getUsedGet + self aetUsedGet
	> self wbSizeGet ifTrue:[^GEFWorkTooBig].

	^0