accessing
allMethodPrototypes 
	^[self class allMethods "Pharo"
		select: [ :each | each category = 'method prototypes' ]]
		on: MessageNotUnderstood
		do: [:ex|
			ex message selector == #allMethods
				ifTrue:
					[self class selectors "Squeak"
						collect: [:s| self class >> s]
						thenSelect: [:m| m protocol = 'method prototypes']]
				ifFalse:
					[ex pass]]