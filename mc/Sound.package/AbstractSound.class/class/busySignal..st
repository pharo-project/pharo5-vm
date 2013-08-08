utilities
busySignal: count
	"AbstractSound busySignal: 3"
	| m s |
	s := SequentialSound new.
	m := MixedSound new.
	m	add: (FMSound new setPitch: 480 dur: 0.5 loudness: 0.5);
		add: (FMSound new setPitch: 620 dur: 0.5 loudness: 0.5).
	s add: m.
	s add: (FMSound new setPitch: 1 dur: 0.5 loudness: 0).
	^ (RepeatingSound repeat: s count: count) play.

