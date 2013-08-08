accessing
currentSound
	currentSound isNil ifTrue: [currentSound := self nextSound].
	^ currentSound