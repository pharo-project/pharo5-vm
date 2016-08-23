send bytecodes
superclassSend
	"Send a message to self, starting lookup with the superclass of the class
	 containing the currently executing method."
	"Assume: messageSelector and argumentCount have been set, and that
	 the receiver and arguments have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	<sharedCodeInCase: #singleExtendedSuperBytecode>
	| superclass |
	superclass := self superclassOf: (self methodClassOf: method).
	"classTagForClass: uses ensureBehaviorHash:"
	lkupClassTag := objectMemory classTagForClass: superclass.
	"To maintain the invariant that all receivers are unforwarded we need an explicit
	 read barrier in the super send cases.  Even though we always follow receivers
	 on become  e.g. super doSomethingWith: (self become: other) forwards the receiver
	 self pushed on the stack."
	self ensureReceiverUnforwarded.
	self assert: lkupClassTag ~= objectMemory nilObject.
	self commonSendOrdinary