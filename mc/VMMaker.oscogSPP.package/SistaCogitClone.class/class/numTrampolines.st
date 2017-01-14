accessing
numTrampolines
	^super numTrampolines + 1

	"Cogit withAllSubclasses collect: [:c| {c. (c instVarNames select: [:ea| ea beginsWith: 'ce']) size}]"
	"self instVarNames select: [:ea| ea beginsWith: 'ce']"