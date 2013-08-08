initialize
getPrimitiveSignatureFor: s
	"Execute the primitive until the send of #primitive:parameters: or primitive:parameters:receiver:,
	collect the processed signature and store it in the map"
	[actualPlugin perform: s withArguments: (1 to: s numArgs) asArray]
		on: Notification
		do: [:ex|
			(ex tag isArray
			 and: [ex tag first == #forMap]) ifTrue:
				[^self computeSignatureFor: s from: ex tag]].
	self error: 'can''t find primitive name in ', s