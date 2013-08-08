processing
nextRandom
	"Answer a random number between 0 and 65535."
	<inline: true>
	seed := (seed * 1309) + 13849 bitAnd: 65535.
	^ seed