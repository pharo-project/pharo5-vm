primitive support
primitiveFailFor: reasonCode
	"Set specific primitive failure.
	 N.B. primitiveFailFor: PrimNoErr is expected to clear the primFailCode."
	<api>
	^primFailCode := reasonCode