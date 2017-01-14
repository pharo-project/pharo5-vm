store check
beRootIfOld: oop 
	"If this object is old, mark it as a root (because a new object
	 may be stored into it)."
	<api>
	<inline: false>
	(self isOldObject: oop) ifTrue:"No, oop is an old object"
		[self possibleRootStoreInto: oop]