transforming
matrix2x3InvertPoint: m
	"Invert the pre-loaded argument point by the given matrix"
	| x y det detX detY |
	<var: #m type: 'float *'>
	<var: #x type: 'double '>
	<var: #y type: 'double '>
	<var: #det type: 'double '>
	<var: #detX type: 'double '>
	<var: #detY type: 'double '>

	x := m23ArgX - (m at: 2).
	y := m23ArgY - (m at: 5).
	det := ((m at: 0) * (m at: 4)) - ((m at: 1) * (m at: 3)).
	det = 0.0 ifTrue:[^interpreterProxy primitiveFail]."Matrix is singular."
	det := 1.0 / det.
	detX := (x * (m at: 4)) - ((m at: 1) * y).
	detY := ((m at: 0) * y) - (x * (m at: 3)).
	m23ResultX := detX * det.
	m23ResultY := detY * det.