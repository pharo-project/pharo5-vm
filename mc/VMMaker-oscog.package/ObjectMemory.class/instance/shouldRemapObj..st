gc -- compaction
shouldRemapObj: oop
	<api>
	"Answer if the oop should be remapped"
	<inline: true>
	^self isObjectForwarded: oop