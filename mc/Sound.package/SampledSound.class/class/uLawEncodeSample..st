utilities
uLawEncodeSample: s
	"Encode the given 16-bit signed sample using the uLaw 8-bit encoding."

	s < 496 ifTrue: [
		s < 112 ifTrue: [
			s < 48 ifTrue: [
				s < 16
					ifTrue: [^ 16r70 bitOr: (15 - s)]
					ifFalse: [^ 16r60 bitOr: (15 - ((s - 16) bitShift: -1))]].
			^ 16r50 bitOr: (15 - ((s - 48) bitShift: -2))].
		s < 240
			ifTrue: [^ 16r40 bitOr: (15 - ((s - 112) bitShift: -3))]
			ifFalse: [^ 16r30 bitOr: (15 - ((s - 240) bitShift: -4))]].

	s < 2032 ifTrue: [
		s < 1008
			ifTrue: [^ 16r20 bitOr: (15 - ((s - 496) bitShift: -5))]
			ifFalse: [^ 16r10 bitOr: (15 - ((s - 1008) bitShift: -6))]].

	s < 4080
		ifTrue: [^ 15 - ((s - 2032) bitShift: -7)]
		ifFalse: [^ 0].
