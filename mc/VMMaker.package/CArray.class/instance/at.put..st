accessing
at: offset put: val
	| ptrAddress |
	ptrAddress := self ptrAddress.
	unitSize = 1 ifTrue: [^ interpreter byteAt: ptrAddress + offset put: val].
	unitSize = 2 ifTrue: [^ interpreter byteAt: ptrAddress + (offset * 2) put: val].
	unitSize = 4 ifTrue: [^ interpreter long32At: ptrAddress + (offset * 4) put: val].
	self halt: 'Can''t handle unitSize ', unitSize printString