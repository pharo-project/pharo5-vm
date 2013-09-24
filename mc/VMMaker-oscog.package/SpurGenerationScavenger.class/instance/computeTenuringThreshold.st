scavenger
computeTenuringThreshold
	| fractionSurvived |
	<var: 'fractionSurvived' type: #float>
	fractionSurvived := (futureSurvivorStart - futureSpace start) asFloat
						/ (futureSpace limit - futureSpace start).
	tenuringThreshold := fractionSurvived > 0.9
							ifTrue: [((pastSpace limit - pastSpace start) * tenuringProportion) rounded + pastSpace start]
							ifFalse: [0]