drag and drop
dragTransferTypeForMorph: dragSource 
	^(dragSource isKindOf: PluggableListMorph)
		ifTrue: [dragSource getListSelector]