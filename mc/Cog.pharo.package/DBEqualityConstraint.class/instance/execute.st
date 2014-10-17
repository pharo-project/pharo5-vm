planning
execute
	"Enforce this constraint. Assume that it is satisfied."
 
	direction == #forward
		ifTrue: [v2 value: v1 value]
		ifFalse: [v1 value: v2 value].