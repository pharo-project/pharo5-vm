sound generation
nextSound
	| answer |
	sounds isEmpty ifTrue: [^ nil].
	answer := sounds next.
	answer reset.
	^ answer