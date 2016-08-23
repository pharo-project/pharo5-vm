forward compatibility
noFixupFollowField: fieldIndex ofObject: anObject
	"Spur compatibility; in V3 this is a synonym for fetchPointer:ofObject:"
	<inline: true>
	^self fetchPointer: fieldIndex ofObject: anObject