simulation stack
allocateRegForStackTopEntryNotConflictingWith: regMask	
	<inline: true>
	^ self allocateRegForStackEntryAt: 0 notConflictingWith: regMask
	