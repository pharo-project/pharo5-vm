printing
printInstructionsOn: aStream do: aBlock
	"Append to the stream, aStream, a description of each bytecode in the instruction stream.
	  Evaluate aBlock with the receiver, the scanner and the stream after each instruction."
	
	| label |
	labelling := true.
	labels := Array new: method size withAll: false.
	super printInstructionsOn: (String new: 1024) writeStream do: [:ig :no :re|].
	label := 0.
	labels withIndexDo:
		[:bool :index|
		bool ifTrue: [labels at: index put: 'L', (label := label + 1) printString]].
	labelling := false.
	super printInstructionsOn: aStream do: aBlock