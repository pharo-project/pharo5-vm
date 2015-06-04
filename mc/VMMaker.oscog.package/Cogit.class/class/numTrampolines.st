accessing
numTrampolines
	^35 "27 + 4 each for self and super sends"

	"self withAllSubclasses collect: [:c| {c. (c instVarNames select: [:ea| ea beginsWith: 'ce']) size}]"