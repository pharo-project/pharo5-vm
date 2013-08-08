utilities
normalized: percentOfFullVolume
	"Increase my amplitudes so that the highest peak is the given percent of full volume. For example 's normalized: 50' would normalize to half of full volume."

	| peak s mult |
	peak := 0.
	1 to: self size do: [:i |
		s := (self at: i) abs.
		s > peak ifTrue: [peak := s]].
	mult := (32767.0 * percentOfFullVolume) / (100.0 * peak).
	1 to: self size do: [:i | self at: i put: (mult * (self at: i)) asInteger].
