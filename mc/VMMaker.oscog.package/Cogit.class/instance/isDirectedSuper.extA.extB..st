bytecode generator support
isDirectedSuper: descriptor extA: exta extB: extb
	"235	(1)	11101011	iiiiijjj	ExtendB < 64
										ifTrue: [Send To Superclass
													Literal Selector #iiiii (+ Extend A * 32)
													with jjj (+ Extend B * 8) Arguments]
										ifFalse: [Send To Superclass of Stacked Class
													Literal Selector #iiiii (+ Extend A * 32)
													with jjj (+ (Extend B bitAnd: 63) * 8) Arguments]"
	<inline: true>
	^descriptor notNil
	  and: [descriptor generator == #genExtSendSuperBytecode
	  and: [extb >= 64]]