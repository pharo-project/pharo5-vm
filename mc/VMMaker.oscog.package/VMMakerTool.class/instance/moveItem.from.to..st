drag and drop
moveItem: transferedMorph from: sourceListMorph to: destListMorph 
	"As part of a drag operation we have to move the item carried by the  
	transfer morph from a source list to a destination list"
	"work out which list is involved and add the item to it"
	| destlist srclist |

	"no need to do anything if we drop on the same place from which we dragged" 
	sourceListMorph = destListMorph
		ifTrue: [^ false].

	(destlist := self listForMorph: destListMorph)
		ifNil: [^ false].
	(srclist := self listForMorph: sourceListMorph)
		ifNil: [^ false].
	vmMaker
		movePlugin: transferedMorph contents
		from: srclist
		to: destlist.
	self changed: sourceListMorph getListSelector.
	self changed: destListMorph getListSelector.
	^ true