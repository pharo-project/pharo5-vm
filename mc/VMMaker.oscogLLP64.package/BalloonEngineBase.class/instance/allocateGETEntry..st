allocating
allocateGETEntry: nSlots
	"Allocate n slots in the global edge table"
	| srcIndex dstIndex |
	<inline: false>
	"First allocate nSlots in the AET"
	(self allocateAETEntry: nSlots) ifFalse:[^false].
	self aetUsedGet = 0 ifFalse:["Then move the AET upwards"
		srcIndex := self aetUsedGet.
		dstIndex := self aetUsedGet + nSlots.
		1 to: self aetUsedGet do:[:i|
			aetBuffer at: (dstIndex := dstIndex - 1) put: (aetBuffer at: (srcIndex := srcIndex - 1))].
	].
	aetBuffer := aetBuffer + nSlots.
	^true