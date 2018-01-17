rendering
render: object
	| string |
	string := self applyOperator: object.
	self stringLength ~= 0
		ifTrue: [ string := string copyFrom: 1 to: (self stringLength min: string size) ].
	width == 0
		ifTrue: [ ^ string ].
	^ (String new: width withAll: self padding)
		copyReplaceFrom: (self startIndexOfCopyReplaceWithStringSize: string size)
		to: (self stopIndexOfCopyReplaceWithStringSize: string size)
		with: string