transforming
matrix2x3ComposeMatrix: m1 with: m2 into: m3
	"Multiply matrix m1 with m2 and store the result into m3."
	| a11 a12 a13 a21 a22 a23 |
	<var: #m1 type: 'const float *'>
	<var: #m2 type: 'const float *'>
	<var: #m3 type: 'float *'>
	<var: #a11 type: 'double '>
	<var: #a12 type: 'double '>
	<var: #a13 type: 'double '>
	<var: #a21 type: 'double '>
	<var: #a22 type: 'double '>
	<var: #a23 type: 'double '>

	a11 := ((m1 at: 0) * (m2 at: 0)) + ((m1 at: 1) * (m2 at: 3)).
	a12 := ((m1 at: 0) * (m2 at: 1)) + ((m1 at: 1) * (m2 at: 4)).
	a13 := ((m1 at: 0) * (m2 at: 2)) + ((m1 at: 1) * (m2 at: 5)) + (m1 at: 2).
	a21 := ((m1 at: 3) * (m2 at: 0)) + ((m1 at: 4) * (m2 at: 3)).
	a22 := ((m1 at: 3) * (m2 at: 1)) + ((m1 at: 4) * (m2 at: 4)).
	a23 := ((m1 at: 3) * (m2 at: 2)) + ((m1 at: 4) * (m2 at: 5)) + (m1 at: 5).

	m3 at: 0 put: (self cCoerce: a11 to: 'float').
	m3 at: 1 put: (self cCoerce: a12 to: 'float').
	m3 at: 2 put: (self cCoerce: a13 to: 'float').
	m3 at: 3 put: (self cCoerce: a21 to: 'float').
	m3 at: 4 put: (self cCoerce: a22 to: 'float').
	m3 at: 5 put: (self cCoerce: a23 to: 'float').
