composition
, aSound
	"Return the concatenation of the receiver and the argument sound."

	^(SequentialSound new)
		add: self;
		add: aSound;
		yourself