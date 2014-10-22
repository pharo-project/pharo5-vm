printing
printInstructionsOn: aStream
	"Append to the stream, aStream, a description of each bytecode in the
	 instruction stream."
	
	| end |
	encoderClass ifNil:
		[^super printInstructionsOn: aStream].
	stackHeightComputer encoderClass: encoderClass.
	stream := aStream.
	scanner := InstructionStream on: method.
	end := method endPC.
	oldPC := scanner pc.
	innerIndents := Array new: end withAll: 0.
	[scanner pc <= end] whileTrue:
		[encoderClass interpretNextInstructionFor: self in: scanner]