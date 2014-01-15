gc -- compaction
mapPointersInObjectsFrom: memStart to: memEnd
	"Use the forwarding table to update the pointers of all non-free objects in the given range of memory.
	 Also remap pointers in root objects which may contains pointers into the given memory range, and
	 don't forget to flush the method cache based on the range."
	<inline: false>
	"update interpreter variables"
	coInterpreter mapInterpreterOops.
	1 to: extraRootCount do:
		[:i | | oop |
		oop := (extraRoots at: i) at: 0.
		((self isIntegerObject: oop) or: [self isFreeObject: oop]) ifFalse:
			[(extraRoots at: i) at: 0 put: (self remap: oop)]].
	coInterpreter flushMethodCacheFrom: memStart to: memEnd.
	self updatePointersInRootObjectsFrom: memStart to: memEnd.
	self updatePointersInRangeFrom: memStart to: memEnd