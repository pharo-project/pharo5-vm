planning
chooseMethod: mark
	"Decide if I can be satisfied and which way I should flow based on the relative strength of the variables I relate, and record that decision."

	v1 mark == mark ifTrue:		"forward or nothing"
		[ ^ direction := ((v2 mark ~= mark) and: [strength stronger: v2 walkStrength])
			ifTrue: [ #forward ]
			ifFalse: [ nil ] ].

	v2 mark == mark ifTrue:		"backward or nothing"
		[ ^ direction := ((v1 mark ~= mark) and: [strength stronger: v1 walkStrength])
			ifTrue: [ #backward ]
			ifFalse: [ nil ] ].

	"if we get here, neither variable is marked, so we have choice"
	(v1 walkStrength weaker: v2 walkStrength)
		ifTrue:
			[ ^ direction := (strength stronger: v1 walkStrength)
				ifTrue: [ #backward ]
				ifFalse: [ nil ]]
		ifFalse:
			[ ^ direction := (strength stronger: v2 walkStrength)
				ifTrue: [ #forward ]
				ifFalse: [ nil ]]. 