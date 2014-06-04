plugin primitive support
methodReturnValue: oop
	"Sets the return value for a method.  In the CoInterpreter we replace the cumbersome
	 primResult machinery."
	self pop: argumentCount+1 thenPush: oop.
	^0