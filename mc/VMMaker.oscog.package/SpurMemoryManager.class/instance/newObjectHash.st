accessing
newObjectHash
	"Use a slight variation on D.H. Lehmer's linear congruential generator from 1951.
	 See e.g. http://en.wikipedia.org/wiki/Linear_congruential_generator."
	| hash |
	[lastHash := self cCode: [lastHash * 16807] "7 raisedTo: 5"
					inSmalltalk: [lastHash := lastHash * 16807 bitAnd: 16rFFFFFFFF].
	 hash := lastHash + (lastHash >> 4). "adding the top bits gives much better spread.  See below:"
	 (hash bitAnd: self identityHashHalfWordMask) = 0] whileTrue.
	^hash

	"the standard algorithm doesn't vary well in the least significant bits:"
	"| r s n |
	r := 1.
	n := 256 * 256 * 256.
	s := Set new: n * 2.
	n timesRepeat:
		[s add: (r bitAnd: n - 1).
		r := r * 16807 bitAnd: 16rFFFFFFFF].
	{ s size. s size / n asFloat. s includes: 0. r hex }
=>	 #(2097152 0.125 false '16r38000001')"

	"this can be improved by adding in shifted upper bits"
	"| r s n |
	r := 1.
	n := 256 * 256 * 256.
	s := Set new: n * 2.
	n timesRepeat:
		[s add: (r + (r bitShift: -8) bitAnd: n - 1).
		r := r * 16807 bitAnd: 16rFFFFFFFF].
	{ s size. s size / n asFloat. s includes: 0. r hex }
=>	#(10702109 0.637895405292511 false '16r38000001')"


"but which shift is best?  Looks like -4:"
"(-2 to: -15 by: -1) do:
	[:shift|
	| r s n |
	r := 1.
	n := 256 * 256 * 256.
	s := Set new: n * 2.
	n timesRepeat:
		[s add: (r + (r bitShift: shift) bitAnd: n - 1).
		r := r * 16807 bitAnd: 16rFFFFFFFF].
	Transcript cr; print: { shift. s size. s size / n asFloat. s includes: 0. r hex }; flush]

#(-2 8388608 0.5 true '16r38000001')
#(-3 8388608 0.5 false '16r38000001')
#(-4 12582503 0.749975621700287 true '16r38000001')
#(-5 11468379 0.6835686564445495 false '16r38000001')
#(-6 11013442 0.656452298164368 true '16r38000001')
#(-7 10804094 0.643974184989929 true '16r38000001')
#(-8 10702109 0.637895405292511 false '16r38000001')
#(-9 10703730 0.637992024421692 false '16r38000001')
#(-10 7865201 0.468802511692047 false '16r38000001')
#(-11 8444092 0.503307104110718 false '16r38000001')
#(-12 10703317 0.6379674077034 true '16r38000001')
#(-13 10701116 0.637836217880249 true '16r38000001')
#(-14 10689443 0.637140452861786 true '16r38000001')
#(-15 7853923 0.4681302905082702 true '16r38000001')"