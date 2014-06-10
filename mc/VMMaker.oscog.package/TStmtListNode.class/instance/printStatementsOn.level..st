printing
printStatementsOn: aStream level: level

	statements size > 1 ifTrue: [ aStream crtab: level + 1 ].
	1 to: statements size do: [ :i |
		(statements at: i) printOn: aStream level: level.
		i = statements size ifTrue: [
			(statements size > 1) ifTrue: [
				aStream crtab: level.
			].
		] ifFalse: [
			aStream nextPut: $.; crtab: level + 1.
		].
	].