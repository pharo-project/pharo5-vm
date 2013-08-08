initialization
nu: order
	"Initialize variables and tables for transforming 2^nu points"
	|  j perms k |
	nu := order.
	n := 2 bitShift: nu-1.

	"Initialize permutation table (bit-reversed indices)"
	j:=0.
	perms := WriteStream on: (Array new: n).
	0 to: n-2 do:
		[:i |
		i < j ifTrue: [perms nextPut: i+1; nextPut: j+1].
		k := n // 2.
		[k <= j] whileTrue: [j := j-k.  k := k//2].
		j := j + k].
	permTable := perms contents.

	"Initialize sin table 0..pi/2 in n/4 steps."
	sinTable := (0 to: n/4) collect: [:i | (i asFloat / (n//4) * Float pi / 2.0) sin]