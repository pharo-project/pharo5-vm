space management
useEdenForSavedFirstFieldsSpace
	"Use teden to hold the savedFirstFieldsSpace."
	<inline: true>
	savedFirstFieldsSpace
		start: scavenger eden start;
		limit: scavenger eden limit.
	savedFirstFieldsSpaceNotInOldSpace := true.
	self deny: self savedFirstFieldsSpaceWasAllocated