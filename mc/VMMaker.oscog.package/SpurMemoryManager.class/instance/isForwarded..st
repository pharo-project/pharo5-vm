object testing
isForwarded: objOop
	"Answer if objOop is that if a forwarder.  Take advantage of isForwardedObjectClassIndexPun
	 being a power of two to generate a more efficient test than the straight-forward
		(self classIndexOf: objOop) = self isForwardedObjectClassIndexPun
	"
	<api>
	^(self longAt: objOop) noMask: self classIndexMask - self isForwardedObjectClassIndexPun