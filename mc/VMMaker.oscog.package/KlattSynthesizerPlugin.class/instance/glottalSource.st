processing-LF
glottalSource
	| x0 |
	<inline: true>
	<returnTypeC: 'float'>
	<var: 'x0' type: 'float '>
	t0 = 0 ifTrue: [^ 0].
	nper < nopen
		ifTrue: [x0 := a1 * x1 + (a2 * x2).
				x2 := x1.
				x1 := x0]
		ifFalse: [x0 := b1 * x1 - c1.
				x1 := x0].
	"Reset period when 'nper' reaches t0."
	nper >= t0 ifTrue: [nper := 0. self pitchSynchronousReset].
	nper := nper + 1.
	^ x0