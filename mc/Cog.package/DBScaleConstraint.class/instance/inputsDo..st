planning
inputsDo: aBlock
	"Evaluate the given block on my current input variable."

	direction == #forward
		ifTrue: [ aBlock 
				value: v1; 
				value: scale; 
				value: offset]
		ifFalse: [ aBlock 
				value: v2; 
				value: scale; 
				value: offset].