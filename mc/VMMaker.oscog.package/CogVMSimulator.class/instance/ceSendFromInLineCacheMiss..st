trampolines
ceSendFromInLineCacheMiss: oPIC
	"Override to map the address into a CogMethodSurrogate"
	| surrogate |
	surrogate := oPIC isInteger
					ifTrue: [cogit cogMethodSurrogateAt: oPIC]
					ifFalse: [oPIC].
	self logSend: surrogate selector.
	(surrogate cmNumArgs = 0
	 and: [(self stackValue: 1) = 16r8169D0
	 and: [self stackTop = 16r53EA7]]) ifTrue:
		[self halt].
	^super ceSendFromInLineCacheMiss: surrogate