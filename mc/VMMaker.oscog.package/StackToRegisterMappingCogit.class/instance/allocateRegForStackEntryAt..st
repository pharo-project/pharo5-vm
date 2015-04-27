simulation stack
allocateRegForStackEntryAt: index
	<inline: true>
	^ self allocateRegForStackEntryAt: index notConflictingWith: 0
	