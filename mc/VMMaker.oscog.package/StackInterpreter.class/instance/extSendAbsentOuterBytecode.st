send bytecodes
extSendAbsentOuterBytecode
	"254		  11111110 	i i i i i j j j	kkkkkkkk Send To Enclosing Object at Depth kkkkkkkk Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	| byte depth |
	byte := self fetchByte.
	messageSelector := self literal: (byte >> 3) + (extA << 5).
	extA := 0.
	argumentCount := (byte bitAnd: 7) + (extB << 3).
	extB := 0.
	depth := self fetchByte.
	self commonSendOuter: depth