gc -- compaction
remapObj: obj
	"Map the given oop to its new value during a compaction or become: operation."
	<inline: false>
	^self remappedObj: obj