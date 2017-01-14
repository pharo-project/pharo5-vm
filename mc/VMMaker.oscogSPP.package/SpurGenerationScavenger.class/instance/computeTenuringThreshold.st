scavenger
computeTenuringThreshold
	| fractionSurvived |
	<var: 'fractionSurvived' type: #float>
	fractionSurvived := futureSpace limit = futureSpace start
							ifTrue:
								[0.0]
							ifFalse:
								[(futureSurvivorStart - futureSpace start) asFloat
									/ (futureSpace limit - futureSpace start)].
	tenureThreshold := fractionSurvived > 0.9
							ifTrue: [((pastSpace limit - pastSpace start) * (1.0 - tenuringProportion)) rounded + pastSpace start]
							ifFalse: [0]