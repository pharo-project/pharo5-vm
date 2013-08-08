sound generation
reset
	super reset.
	self currentSound notNil
		ifTrue: [self currentSound reset]
		ifFalse: [self currentSound: self nextSound]