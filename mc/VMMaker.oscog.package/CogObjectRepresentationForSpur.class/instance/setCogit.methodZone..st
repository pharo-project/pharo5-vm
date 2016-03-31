in-line cacheing
setCogit: aCogit methodZone: aMethodZone
	<doNotGenerate>
	super setCogit: aCogit methodZone: aMethodZone.
	ceStoreTrampolines := CArrayAccessor on: (Array new: self numStoreTrampolines + 1).