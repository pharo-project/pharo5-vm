primitive test
sineTable: size
	"Compute a sine table of the given size. Used for testing only."

	| radiansPerStep table |
	table := Array new: size.
	radiansPerStep := (2.0 * Float pi) / table size asFloat.
	1 to: table size do: [:i |
		table at: i put:
			(32767.0 * (radiansPerStep * i) sin) asInteger].

	^ table
