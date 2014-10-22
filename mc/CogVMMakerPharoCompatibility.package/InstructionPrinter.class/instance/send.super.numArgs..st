instruction decoding
send: selector super: supered numArgs: numArgs
	"Print the Send Message With Selector, selector, bytecode. The argument, 
	supered, indicates whether the receiver of the message is specified with 
	'super' in the source method. The arguments of the message are found in 
	the top numArguments locations on the stack and the receiver just 
	below them."

	self print: (supered
				ifTrue: ['superSend: ']
				ifFalse: ['send: '])
			, (self stringForSelector: selector numArgs: numArgs).
	indentSpanOfFollowingJump := #(blockCopy: #closureCopy:copiedValues:) includes: selector