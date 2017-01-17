accessing
numTrampolines
	^super numTrampolines + 2 "includes long sendMustBeBoolean trampolines"

	"Cogit withAllSubclasses, CogObjectRepresentation withAllSubclasses collect:
		[:c| {c. (c instVarNames select: [:ea| ea beginsWith: 'ce']) size}]"
	"self allInstVarNames select: [:ea| ea beginsWith: 'ce']"
	"self instVarNames select: [:ea| ea beginsWith: 'ce']"