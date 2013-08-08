C core util
cHighBit: uint 
	"Answer the index of the high order bit of the argument, or zero if the  
	argument is zero."
	"For 64 bit uints there could be added a 32-shift."
	| shifted bitNo |

	<var: #shifted type: 'unsigned int  '>
	shifted := uint.
	bitNo := 0.
	shifted < (1 << 16)
		ifFalse: [shifted := shifted bitShift: -16.
			bitNo := bitNo + 16].
	shifted < (1 << 8)
		ifFalse: [shifted := shifted bitShift: -8.
			bitNo := bitNo + 8].
	shifted < (1 << 4)
		ifFalse: [shifted := shifted bitShift: -4.
			bitNo := bitNo + 4].
	shifted < (1 << 2)
		ifFalse: [shifted := shifted bitShift: -2.
			bitNo := bitNo + 2].
	shifted < (1 << 1)
		ifFalse: [shifted := shifted bitShift: -1.
			bitNo := bitNo + 1].
	"shifted 0 or 1 now"
	^ bitNo + shifted