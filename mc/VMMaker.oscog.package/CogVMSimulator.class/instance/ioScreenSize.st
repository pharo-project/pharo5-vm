I/O primitives support
ioScreenSize
	"Answer the screen extent packed into 32 bits.  In the simulator,
	 displayForm gets initialized with a fake form; don't be deceived."
	| extent |
	extent := (displayForm notNil and: [displayForm ~~ fakeForm])
				ifTrue: [displayForm extent]
				ifFalse: [self desiredDisplayExtent].
	^extent x << 16 + extent y