converting
asCArrayAccessor

	^ (CArrayAccessor on: self)
			+= -1   "Defeat the +1 offset in the accessor"