inline primitive register allocation
isOopRegister: register usedBefore: stackIndex
	<option: #LowcodeVM>
	<inline: true>
	| index |
	index := simSpillBase max: 0.
	index to: simStackPtr - stackIndex do: [ :i |
		(self simStackAt: index) registerOrNone = register ifTrue: [ 
			^ true
		]
	].

	^ false