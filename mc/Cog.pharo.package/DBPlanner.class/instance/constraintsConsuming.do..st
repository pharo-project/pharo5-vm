private
constraintsConsuming: v do: aBlock

	| determiningC |
	determiningC := v determinedBy.
	v constraints do:
		[ :c |
		 (c == determiningC or: [c isSatisfied not]) ifFalse:
			[aBlock value: c]].