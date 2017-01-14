gc -- compaction
remap: oop
	<api>
	"Map the given oop to its new value during a compaction or 
	become: operation. If it has no forwarding table entry, 
	return the oop itself."
	<inline: false>
	(self isObjectForwarded: oop) ifTrue:
		[^self remappedObj: oop].
	^ oop