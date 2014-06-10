method map
mapFor: cogMethod bcpc: startbcpc performUntil: functionSymbol arg: arg
	"as a hack for collecting counters, remember the prev mcpc in a static variable."
	prevMapAbsPCMcpc := 0.
	^super mapFor: cogMethod bcpc: startbcpc performUntil: functionSymbol arg: arg