accessing
scavengerTenuringThreshold: aProportion "(Slang flattens so need unique selectors)"
	<var: 'aProportion' type: #double>
	tenuringProportion := aProportion.
	tenureThreshold := aProportion = 0.0
							ifTrue: [0]
							ifFalse: [((pastSpace limit - pastSpace start) * (1.0 - aProportion)) rounded + pastSpace start]