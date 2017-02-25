space management
savedFirstFieldsSpaceInFreeChunk
	<inline: true>
	^savedFirstFieldsSpaceNotInOldSpace not
	 and: [self oop: savedFirstFieldsSpace start isGreaterThan: manager nilObject]