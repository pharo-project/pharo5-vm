utilities
hangUpWarning: count
	"AbstractSound hangUpWarning: 20"
	| m s |
	s := SequentialSound new.
	m := MixedSound new.
	m	add: (FMSound new setPitch: 1400 dur: 0.1 loudness: 0.5);
		add: (FMSound new setPitch: 2060 dur: 0.1 loudness: 0.5).
	s add: m; add: (FMSound new setPitch: 1 dur: 0.1 loudness: 0).
	^ (RepeatingSound repeat: s count: count) play

