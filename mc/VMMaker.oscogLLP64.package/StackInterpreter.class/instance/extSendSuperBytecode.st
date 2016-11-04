send bytecodes
extSendSuperBytecode
	"239		11101111	i i i i i j j j
		ExtendB < 64
			ifTrue: [Send To Superclass Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments]
			ifFalse: [Send To Superclass of Stacked Class Literal Selector #iiiii (+ Extend A * 32) with jjj (+ (Extend B bitAnd: 63) * 8) Arguments]"
	| byte |
	byte := self fetchByte.
	messageSelector := self literal: (byte >> 3) + (extA << 5).
	extA := 0.
	BytecodeSetHasDirectedSuperSend ifTrue:
		[extB >= 64 ifTrue:
			[argumentCount := (byte bitAnd: 7) + (extB - 64 << 3).
			 extB := 0.
			 ^self directedSuperclassSend]].
	argumentCount := (byte bitAnd: 7) + (extB << 3).
	extB := 0.
	self superclassSend