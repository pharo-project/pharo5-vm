setup
reloadDestAndSourceForms
	"A GC has occurred.  The destForm must be updated.  But where to derive it from?
	  For copyBits and warpBits it is derived from the receiver.  But for a BalloonEnginePlugin
	  it should be obtained from (interpreterProxy fetchPointer: BEBitBltIndex ofObject: engine).
	  For the moment implement something that works for these two cases."
	<inline: false>
	| receiver |
	receiver := interpreterProxy stackValue: interpreterProxy methodArgumentCount.
	bitBltIsReceiver ifFalse: [receiver := interpreterProxy fetchPointer: BEBitBltIndex ofObject: receiver].
	destForm := interpreterProxy fetchPointer: BBDestFormIndex ofObject: receiver.
	sourceForm := interpreterProxy fetchPointer: BBSourceFormIndex ofObject: receiver