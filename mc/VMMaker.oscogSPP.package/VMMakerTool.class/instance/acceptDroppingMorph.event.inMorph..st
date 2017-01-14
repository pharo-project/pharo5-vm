drag and drop
acceptDroppingMorph: transferMorph event: evt inMorph: aMorph
	"Here we are fetching information from the dropped transferMorph and performing the correct action for this drop.
	As long as the source is part of this tool, move the dragged item from the source list to the destination list"

	^self moveItem: transferMorph passenger from: transferMorph source to: aMorph