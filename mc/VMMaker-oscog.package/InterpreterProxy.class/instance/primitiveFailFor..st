other
primitiveFailFor: reasonCode
	"Set specific primitive failure.
	 N.B. primitiveFailFor: PrimNoErr is expected to clear the primFailCode."
	(self confirm:'A primitive is failing -- Stop simulation?') ifTrue:[self halt].
	^primFailCode := reasonCode