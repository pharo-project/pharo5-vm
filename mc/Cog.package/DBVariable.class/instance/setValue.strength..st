update
setValue: aValue strength: strengthSymbol
	"Attempt to assign the given value to me using the given strength."

	| editConstraint |
	editConstraint := DBEditConstraint var: self strength: strengthSymbol.
	(editConstraint isSatisfied) ifTrue:
		[self value: aValue.
		 DBPlanner propagateFrom: self].
	editConstraint destroyConstraint.