simulation
simulatePrimitive: aString receiver: rcvr args: args

	| proxy bb |
	proxy := InterpreterProxy new.
	proxy synthesizeStackFor: rcvr with: args.
	bb := self simulatorClass new.
	bb setInterpreter: proxy.
	bb initialiseModule.
	"rendering state is loaded in the primitive implementations"
	[bb perform: aString asSymbol] on: Exception do: [:ex |
		proxy success: false].
	^ proxy stackValue: 0
