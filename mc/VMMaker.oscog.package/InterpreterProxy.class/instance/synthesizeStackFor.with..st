initialize
synthesizeStackFor: receiver with: args
	<doNotGenerate>
	self push: receiver.
	argumentCount := args size.
	1 to: argumentCount do: [:i | self push: (args at: i)].