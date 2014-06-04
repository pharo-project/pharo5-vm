compaction
copyAndForward: objOop withBytes: bytes toFreeChunk: freeChunk
	"Copy and forward objOop to freeChunk, the inner operation in compaction."

	<inline: true>
	| startOfObj freeObj |
	startOfObj := self startOfObject: objOop.
	self mem: freeChunk asVoidPointer cp: startOfObj asVoidPointer y: bytes.
	freeObj := freeChunk + (objOop - startOfObj).
	"leave it to followRememberedForwarders to remember..."
	"(self isRemembered: objOop) ifTrue:
		[scavenger remember: freeObj]."
	self forward: objOop to: freeObj