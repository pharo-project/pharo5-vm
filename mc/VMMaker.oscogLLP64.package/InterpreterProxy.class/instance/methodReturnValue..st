stack access
methodReturnValue: oop
	"Sets the return value for a method"
	self pop: argumentCount+1 thenPush: oop.
	^0