utilities
dialTone: duration
	"AbstractSound dialTone: 2"
	| m |
	m := MixedSound new.
	m add: (FMSound new setPitch: 350 dur: duration loudness: 0.5).
	m add: (FMSound new setPitch: 440 dur: duration loudness: 0.5).
	m play.
	^ m