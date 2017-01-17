processing-voice
addJitter
	"Add jitter (random F0 perturbation)."
	<returnTypeC: 'void'>
	pitch := pitch + (self nextRandom - 32767 * (frame at: Jitter) / 32768.0 * (frame at: F0))