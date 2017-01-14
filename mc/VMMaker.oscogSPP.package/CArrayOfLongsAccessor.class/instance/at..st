accessing
at: index
	"Map at: into a suitably aligned and offset longAt:, for accessing Arrays stored in the heap, such as the primTraceLog."
	^objectMemory longAt: index * elementByteSize + address