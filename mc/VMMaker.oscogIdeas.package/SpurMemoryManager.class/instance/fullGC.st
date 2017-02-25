gc - global
fullGC
	"Perform a full lazy compacting GC.  Answer the size of the largest free chunk."
	<returnTypeC: #usqLong>
	<inline: #never> "for profiling"
	needGCFlag := false.
	gcStartUsecs := coInterpreter ioUTCMicrosecondsNow.
	statMarkCount := 0.
	coInterpreter preGCAction: GCModeFull.
	self globalGarbageCollect.
	coInterpreter postGCAction: GCModeFull.
	statFullGCs := statFullGCs + 1.
	statGCEndUsecs := coInterpreter ioUTCMicrosecondsNow.
	statFullGCUsecs := statFullGCUsecs + (statGCEndUsecs - gcStartUsecs).
	statCompactionUsecs := statCompactionUsecs + (statGCEndUsecs - compactionStartUsecs).
	^(freeLists at: 0) ~= 0
		ifTrue: [self bytesInObject: self findLargestFreeChunk]
		ifFalse: [0]