accessing
postTrapCorrectedPC
	"return the pc - 8 for trap handling - remember the ARM alwayshas that funky +8 offset vs the actual instruction running/failig"
	^self pc -8