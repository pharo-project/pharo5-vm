private
changeVar: aVariable newValue: newValue

	| editConstraint plan |
	editConstraint := DBEditConstraint var: aVariable strength: #preferred.
	plan := self extractPlanFromConstraints: (Array with: editConstraint).
	10 timesRepeat: [
		aVariable value: newValue.
		plan execute].
	editConstraint destroyConstraint.