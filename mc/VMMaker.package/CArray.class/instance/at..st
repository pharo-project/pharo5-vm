accessing
at: offset
	| ptrAddress |
	ptrAddress := self ptrAddress.
	unitSize = 1 ifTrue: [^ interpreter byteAt: ptrAddress + offset].
	unitSize = 2 ifTrue: [^ interpreter shortAt: ptrAddress + (offset * 2)].
	unitSize = 4 ifTrue: [^ interpreter long32At: ptrAddress + (offset * 4)].
	self halt: 'Can''t handle unitSize ', unitSize printString