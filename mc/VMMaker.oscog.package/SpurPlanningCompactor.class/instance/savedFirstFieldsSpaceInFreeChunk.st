space management
savedFirstFieldsSpaceInFreeChunk
	<inline: true>
	^savedFirstFieldsSpaceNotInOldSpace not and: [savedFirstFieldsSpace start >= manager nilObject]