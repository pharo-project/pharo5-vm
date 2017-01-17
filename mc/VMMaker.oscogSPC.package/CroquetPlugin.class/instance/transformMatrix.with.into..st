transforms
transformMatrix: src with: arg into: dst
	"Transform src with arg into dst.
	It is allowed that src == dst but not arg == dst"
	| m1 m2 m3 c1 c2 c3 c4 |
	<var: #src declareC:'float *src'>
	<var: #arg declareC:'float *arg'>
	<var: #dst declareC:'float *dst'>
	<var: #m1 declareC:'float *m1'>
	<var: #m2 declareC:'float *m2'>
	<var: #m3 declareC:'float *m3'>

	<var: #c1 declareC:'double c1'>
	<var: #c2 declareC:'double c2'>
	<var: #c3 declareC:'double c3'>
	<var: #c4 declareC:'double c4'>

	m1 := self cCoerce: src to:'float *'.
	m2 := self cCoerce: arg to: 'float *'.
	m3 := self cCoerce: dst to: 'float *'.

	0 to: 3 do:[:i|

		"Compute next row"
		c1 := ((m1 at: 0) asFloat * (m2 at: 0) asFloat) + ((m1 at: 1) asFloat * (m2 at: 4) asFloat) +
			((m1 at: 2) asFloat * (m2 at: 8) asFloat) + ((m1 at: 3) asFloat * (m2 at: 12) asFloat).

		c2 := ((m1 at: 0) asFloat * (m2 at: 1) asFloat) + ((m1 at: 1) asFloat * (m2 at: 5) asFloat) +
			((m1 at: 2) asFloat * (m2 at: 9) asFloat) + ((m1 at: 3) asFloat * (m2 at: 13) asFloat).

		c3 := ((m1 at: 0) asFloat * (m2 at: 2) asFloat) + ((m1 at: 1) asFloat * (m2 at: 6) asFloat) +
			((m1 at: 2) asFloat * (m2 at: 10) asFloat) + ((m1 at: 3) asFloat * (m2 at: 14) asFloat).

		c4 := ((m1 at: 0) asFloat * (m2 at: 3) asFloat) + ((m1 at: 1) asFloat * (m2 at: 7) asFloat) +
			((m1 at: 2) asFloat * (m2 at: 11) asFloat) + ((m1 at: 3) asFloat * (m2 at: 15) asFloat).

		"Store result"
		m3 at: 0 put: c1.
		m3 at: 1 put: c2.
		m3 at: 2 put: c3.
		m3 at: 3 put: c4.

		"Skip src and dst to next row"
		m1 := m1 + 4.
		m3 := m3 + 4.
	].

	^nil
