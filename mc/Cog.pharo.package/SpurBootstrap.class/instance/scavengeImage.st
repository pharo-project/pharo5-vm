bootstrap image
scavengeImage
	"Scavenge the image to get it into a simpler state."
	newHeap coInterpreter voidVMStateForSnapshotFlushingExternalPrimitivesIf: false.
	newHeap flushNewSpace