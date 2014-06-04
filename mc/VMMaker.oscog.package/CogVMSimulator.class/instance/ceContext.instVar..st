trampolines
ceContext: aOnceMarriedContext instVar: slotIndex
	"aOnceMarriedContext = 26431360 ifTrue: [self halt]."
	cogit assertCStackWellAligned.
	^super ceContext: aOnceMarriedContext instVar: slotIndex