sound generation
reset
	"Fill the ring with random noise."

	| seed n |
	super reset.
	seed := 17.
	n := ring monoSampleCount.
	1 to: n do: [:i |
		seed := ((seed * 1309) + 13849) bitAnd: 65535.
		ring at: i put: seed - 32768].
	count := initialCount.
	scaledIndex := ScaleFactor.
