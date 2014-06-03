processing-LF
normalizeGlottalPulse
	| s1 s2 s0 |
	<inline: true>
	<returnTypeC: 'void'>
	<var: 's0' type: 'float '>
	<var: 's1' type: 'float '>
	<var: 's2' type: 'float '>
	s0 := 0.0.
	s1 := x1.
	s2 := x2.
	1 to: nopen do: [ :ingore |
		s0 := a1 * s1 + (a2 * s2).
		s2 := s1.
		s1 := s0].
	s0 = 0.0 ifFalse: [x1 := x1 / s0 * 10000.0]