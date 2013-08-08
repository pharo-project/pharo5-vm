gc -- compaction
forwardingPointerOf: forwardedObj
	"Answer the pointer to the given forwardedOop's forwarding block."
	<inline: true>
	^((self longAt: forwardedObj) bitAnd: AllButMarkBitAndTypeMask) << 1