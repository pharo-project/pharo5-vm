accessing
at: index put: aValue
	"Map at:put: into a suitably aligned and offset longAt:put:, for accessing Arrays stored in the heap, such as the primTraceLog."
	^objectMemory longAt: index * elementByteSize + address put: aValue