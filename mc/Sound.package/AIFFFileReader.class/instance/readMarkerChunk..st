private
readMarkerChunk: chunkSize

	| markerCount id position labelBytes label |
	markerCount := in nextNumber: 2.
	markers := Array new: markerCount.
	1 to: markerCount do: [:i |
		id := in nextNumber: 2.
		position := in nextNumber: 4.
		labelBytes := in next.
		label := (in next: labelBytes) asString.
		labelBytes even ifTrue: [in skip: 1].
		markers at: i put: (Array with: id with: label with: position)].

