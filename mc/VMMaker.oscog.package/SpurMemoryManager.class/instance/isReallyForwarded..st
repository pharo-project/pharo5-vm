object testing
isReallyForwarded: objOop
	"This version is for asserts.  It does not take advantage of the power-of0two optimization
	 in isForwarded:."
	<api>
	^(self classIndexOf: objOop) = self isForwardedObjectClassIndexPun