FILL processing
hideFill: fillIndex depth: depth
	"Make the fill style with the given index invisible"
	| index newTopIndex newTop newDepth newRightX |
	<inline: false>
	index := self findStackFill: fillIndex depth: depth.
	index = -1 ifTrue:[^false].

	index = 0 ifTrue:[
		self freeStackFillEntry.
		^true].

	"Fill is visible - replace it with the last entry on the stack"
	self stackFillValue: index put: (self stackFillValue: 0).
	self stackFillDepth: index put: (self stackFillDepth: 0).
	self stackFillRightX: index put: (self stackFillRightX: 0).
	self freeStackFillEntry.
	(self stackFillSize <= self stackFillEntryLength) ifTrue:[^true]. "Done"

	"Find the new top fill"
	newTopIndex := 0.
	index := self stackFillEntryLength.
	[index < self stackFillSize] whileTrue:[
		(self fillSorts: index before: newTopIndex)
			ifTrue:[newTopIndex := index].
		index := index + self stackFillEntryLength.
	].
	(newTopIndex + self stackFillEntryLength = self stackFillSize) 
		ifTrue:[^true]. "Top fill not changed"
	newTop := self stackFillValue: newTopIndex.
	self stackFillValue: newTopIndex put: self topFillValue.
	self topFillValuePut: newTop.
	newDepth := self stackFillDepth: newTopIndex.
	self stackFillDepth: newTopIndex put: self topFillDepth.
	self topFillDepthPut: newDepth.
	newRightX := self stackFillRightX: newTopIndex.
	self stackFillRightX: newTopIndex put: self topFillRightX.
	self topFillRightXPut: newRightX.
	^true