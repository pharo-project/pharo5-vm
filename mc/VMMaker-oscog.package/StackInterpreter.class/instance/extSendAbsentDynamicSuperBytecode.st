send bytecodes
extSendAbsentDynamicSuperBytecode
	"241		11110001	i i i i i j j j	Send To Dynamic Superclass Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	| byte mClassMixin mixinApplication |
	byte := self fetchByte.
	messageSelector := self literal: (byte >> 3) + (extA << 5).
	extA := 0.
	argumentCount := (byte bitAnd: 7) + (extB << 3).
	extB := 0.
	self shuffleArgumentsAndStoreAbsentReceiver: self receiver.
	mClassMixin := self methodClassOf: method.
	mixinApplication := self 
							findApplicationOfTargetMixin: mClassMixin
							startingAtBehavior: (objectMemory fetchClassOf: self receiver).
	lkupClassTag := objectMemory classTagForClass: (self superclassOf: mixinApplication).
	self commonSend