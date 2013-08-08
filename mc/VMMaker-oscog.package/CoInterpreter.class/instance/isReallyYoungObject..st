cog jit support
isReallyYoungObject: obj
	<api>
	"For machine code assertion checking.  Answer true if not in a fullGC and obj is young."
	^gcMode ~= GCModeFull
	  and: [self oop: obj isGreaterThanOrEqualTo: objectMemory youngStart]