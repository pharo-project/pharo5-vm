object testing
isUnambiguouslyForwarder: objOop
	"This version is private to SpurMemoryManager (for asserts, etc).  It does not
	 take advantage of the power-of0two optimization in isForwarded:."
	<api>
	^(self classIndexOf: objOop) = self isForwardedObjectClassIndexPun