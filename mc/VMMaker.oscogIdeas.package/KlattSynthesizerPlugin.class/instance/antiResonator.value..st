resonators
antiResonator: index value: aFloat
	| answer p1 |
	<inline: true>
	<returnTypeC: 'float'>
	<var: 'aFloat' type: 'double '>
	<var: 'answer' type: 'double '>
	<var: 'p1' type: 'double '>
	answer := (self resonatorA: index) * aFloat
			+ ((self resonatorB: index) * (p1 := self resonatorP1: index))
			+ ((self resonatorC: index) * (self resonatorP2: index)).
	self resonatorP2: index put: p1.
	self resonatorP1: index put: aFloat.
	^ answer