message sending
noFixupSuperclassOf: classPointer
	"No fixup version of superclassOf: that should not create heisenbugs"
	<inline: true>
	^objectMemory noFixupFollowField: SuperclassIndex ofObject: classPointer