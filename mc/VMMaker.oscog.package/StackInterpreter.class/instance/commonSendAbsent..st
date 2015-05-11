send bytecodes
commonSendAbsent: lookupRule
	"Send an absent receiver message, shuffling arguments and inserting the absent
	 receiver for the send.  Assume: messageSelector and argumentCount have been
	 set, and that the arguments but not the receiver have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	"160-175	1010 i i i i				Send To Absent Implicit Receiver Literal Selector #iiii With 0 Arguments"
	"240		11110000	i i i i i j j j	Send To Absent Implicit Receiver Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	"245		 11110101 i i i i i j j j	Send To Self Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	"254		 11111110 i i i i i j j j	kkkkkkkk Send To Enclosing Object at Depth kkkkkkkk Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	"<sharedCodeInCase: #extSendAbsentImplicitBytecode>"
	self shuffleArgumentsAndStoreAbsentReceiver: localAbsentReceiver.
	lkupClassTag := objectMemory fetchClassTagOf: localAbsentReceiver.
	self assert: (objectMemory classForClassTag: lkupClassTag) ~= objectMemory nilObject.
	CheckPrivacyViolations ifTrue:
            [isPrivateSend := true].
	self commonSend: lookupRule