trampolines
ceSendFromInLineCacheMiss: oPIC
	"Override to map the address into a CogMethodSurrogate"
	| surrogate |
	surrogate := oPIC isInteger
					ifTrue: [cogit cogMethodSurrogateAt: oPIC]
					ifFalse: [oPIC].
	self logSend: surrogate selector.
	^super ceSendFromInLineCacheMiss: surrogate