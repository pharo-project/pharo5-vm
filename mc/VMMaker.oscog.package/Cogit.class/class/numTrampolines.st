accessing
numTrampolines
	^38 "30 + 4 each for self and super sends" + (LowcodeVM ifTrue: [1] ifFalse: [0])

	"self withAllSubclasses collect: [:c| {c. (c instVarNames select: [:ea| ea beginsWith: 'ce']) size}]"