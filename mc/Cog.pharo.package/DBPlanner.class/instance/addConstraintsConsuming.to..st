private
addConstraintsConsuming: v to: aCollection

	| determiningC |
	determiningC := v determinedBy.
	v constraints do:
		[ :c |
		 (c == determiningC or: [c isSatisfied not]) ifFalse:
			[aCollection add: c]].