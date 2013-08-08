utilities
uLawEncode: anArray
	"Convert the given array of 16-bit signed samples into a ByteArray of uLaw-encoded 8-bit samples."

	| n out s |
	n := anArray size.
	out := ByteArray new: n.
	1 to: n do: [:i |
		s := anArray at: i.
		s := s bitShift: -3.  "drop 4 least significant bits"
		s < 0
			ifTrue: [s := (self uLawEncodeSample: s negated) bitOr: 16r80]
			ifFalse: [s := (self uLawEncodeSample: s)].
		out at: i put: s].
	^ out
