cog jit support
isReallyYoungObject: obj
	<api>
	"For machine code assertion checking.  Answer true if not in a fullGC and obj is young."
	^coInterpreter gcMode ~= GCModeFull
	  and: [self oop: obj isGreaterThanOrEqualTo: self youngStart]