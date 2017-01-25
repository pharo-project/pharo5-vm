space management
savedFirstFieldsSpaceWasAllocated
	<inline: true>
	^savedFirstFieldsSpaceNotInOldSpace
	 and: [self oop: savedFirstFieldsSpace start isGreaterThan: manager nilObject]