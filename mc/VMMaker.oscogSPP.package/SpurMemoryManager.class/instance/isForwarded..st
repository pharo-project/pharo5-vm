object testing
isForwarded: objOop
	"Answer if objOop is that if a forwarder.  Take advantage of isForwardedObjectClassIndexPun
	 being a power of two to generate a more efficient test than the straight-forward
		(self classIndexOf: objOop) = self isForwardedObjectClassIndexPun
	 at the cost of this being ambiguous with free chunks.  So either never apply this to free chunks
	 or guard with (self isFreeObject: foo) not.  So far the idiom has been to guard with isFreeObject:"
	<api>
	<inline: true>
	"self assert: (self isFreeObject: objOop) not."
	^(self longAt: objOop) noMask: self classIndexMask - self isForwardedObjectClassIndexPun