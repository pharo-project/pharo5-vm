send bytecodes
dynamicSuperSendBytecode
"Send a message to self, starting lookup in the superclass of the method application of the currently executing method's mixin."
"Assume: messageSelector and argumentCount have been set, and that the receiver and arguments have been pushed onto the stack," 
"WE WANT THE RECEIVER PUSHED IMPLICITLY, BUT IT IS NOT - SO FAR"
"Note: This method is inlined into the interpreter dispatch loop."
	| rcvr mClassMixin mixinApplication |
	<inline: true>
	argumentCount := self fetchByte.
	messageSelector := self literal: self fetchByte.
	rcvr := self internalStackValue: argumentCount.
	mClassMixin := self methodClassOf: method.
	mixinApplication := self 
		findApplicationOfTargetMixin: mClassMixin
		startingAtBehavior: (objectMemory fetchClassOf: rcvr).
	lkupClassTag := objectMemory classTagForClass: (self superclassOf: mixinApplication).
	self commonSend