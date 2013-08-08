memory space primitives
primitiveFullGC
	"Do a full garbage collection and return the number of bytes available (including swap space if dynamic memory management is supported)."

	self pop: 1.
	self incrementalGC.  "maximimize space for forwarding table"
	self fullGC.
	self pushInteger: (self bytesLeft: true).