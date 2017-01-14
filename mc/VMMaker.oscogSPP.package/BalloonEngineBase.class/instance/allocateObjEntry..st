allocating
allocateObjEntry: nSlots
	"Allocate n slots in the object buffer"
	| srcIndex dstIndex |
	<inline: false>
	"First allocate nSlots in the GET"
	(self allocateGETEntry: nSlots) ifFalse:[^false].
	self getUsedGet = 0 ifFalse:["Then move the GET upwards"
		srcIndex := self getUsedGet.
		dstIndex := self getUsedGet + nSlots.
		1 to: self getUsedGet do:[:i|
			getBuffer at: (dstIndex := dstIndex - 1) put: (getBuffer at: (srcIndex := srcIndex - 1))].
	].
	getBuffer := getBuffer + nSlots.
	^true