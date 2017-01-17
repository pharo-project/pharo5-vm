store check
possibleRootStoreInto: destObj
	<inline: true>
	(self isRemembered: destObj) ifFalse:
		[scavenger remember: destObj]