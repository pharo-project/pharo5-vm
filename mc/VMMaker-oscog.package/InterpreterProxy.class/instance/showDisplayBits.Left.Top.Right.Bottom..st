other
showDisplayBits: aForm Left: l Top: t Right: r Bottom: b
	aForm == Display ifTrue:[
		Display forceToScreen: (Rectangle left: l right: r top: t bottom: b)].