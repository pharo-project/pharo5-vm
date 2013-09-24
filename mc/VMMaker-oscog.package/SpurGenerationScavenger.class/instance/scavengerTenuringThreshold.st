accessing
scavengerTenuringThreshold "(Slang flattens so need unique selectors)"
	<returnTypeC: #float>
	^tenuringThreshold >= pastSpace start
		ifTrue: [(tenuringThreshold - pastSpace start) asFloat / (pastSpace limit - pastSpace start)]
		ifFalse: [0]