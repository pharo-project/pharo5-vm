testing
isInSegments: address
	<var: #address type: #usqInt>
	0 to: numSegments - 1 do:
		[:i|
		address < (segments at: i) segStart ifTrue:
			[^false].
		address < (segments at: i) segLimit ifTrue:
			[^true]].
	^false