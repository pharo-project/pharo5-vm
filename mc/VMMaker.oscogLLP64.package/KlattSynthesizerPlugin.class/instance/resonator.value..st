resonators
resonator: index value: aFloat
	| answer p1 |
	<inline: true>
	<returnTypeC: 'float'>
	<var: 'aFloat' type: 'float '>
	<var: 'answer' type: 'float '>
	<var: 'p1' type: 'float '>
	answer := (self resonatorA: index) * aFloat
			+ ((self resonatorB: index) * (p1 := self resonatorP1: index))
			+ ((self resonatorC: index) * (self resonatorP2: index)).
	"(p1 between: -100000 and: 100000) ifFalse: [self halt].
	(answer between: -100000 and: 100000) ifFalse: [self halt]."
	self resonatorP2: index put: p1.
	self resonatorP1: index put: answer.
	^ answer