accessing
scavengerTenuringThreshold: aProportion "(Slang flattens so need unique selectors)"
	<var: 'aProportion' type: #float>
	tenuringProportion := aProportion.
	tenuringThreshold := aProportion = 0.0
							ifTrue: [0]
							ifFalse: [((pastSpace limit - pastSpace start) * aProportion) rounded + pastSpace start]