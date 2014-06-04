store check
possibleRootStoreInto: destObj
	(self isRemembered: destObj) ifFalse:
		[scavenger remember: destObj.
		 self setIsRememberedOf: destObj to: true]