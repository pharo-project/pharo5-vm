accessing
scavengerTenuringThreshold "(Slang flattens so need unique selectors)"
	<returnTypeC: #float>
	^tenureThreshold >= pastSpace start
		ifTrue: [(tenureThreshold - pastSpace start) asFloat / (pastSpace limit - pastSpace start)]
		ifFalse: [0]