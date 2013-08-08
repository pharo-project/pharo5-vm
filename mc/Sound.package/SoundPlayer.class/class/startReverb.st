player process
startReverb
	"Start a delay-line style reverb with the given tap delays and gains. Tap delays are given in samples and should be prime integers; the following comment gives an expression that generates primes."
	"Integer primesUpTo: 22050"

	UseReverb := true.
	ReverbState := ReverbSound new
		tapDelays: #(1601 7919) gains: #(0.12 0.07).
