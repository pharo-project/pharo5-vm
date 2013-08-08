composition
+ aSound
	"Return the mix of the receiver and the argument sound."

	^(MixedSound new)
		add: self;
		add: aSound;
		yourself
