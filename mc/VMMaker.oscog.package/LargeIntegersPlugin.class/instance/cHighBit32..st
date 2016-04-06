C core util
cHighBit32: anUnsignedInt32 
	"Answer the index of the high order bit of the argument, or zero if the  
	argument is zero."
	| shifted bitNo |

	<var: #anUnsignedInt32 type: #'unsigned int'>
	<var: #shifted type: #'unsigned int'>
	shifted := anUnsignedInt32.
	bitNo := 0.
	shifted < (1 << 16)
		ifFalse: [shifted := shifted >> 16.
			bitNo := bitNo + 16].
	shifted < (1 << 8)
		ifFalse: [shifted := shifted >> 8.
			bitNo := bitNo + 8].
	shifted < (1 << 4)
		ifFalse: [shifted := shifted >> 4.
			bitNo := bitNo + 4].
	shifted < (1 << 2)
		ifFalse: [shifted := shifted >> 2.
			bitNo := bitNo + 2].
	shifted < (1 << 1)
		ifFalse: [shifted := shifted >> 1.
			bitNo := bitNo + 1].
	"shifted 0 or 1 now"
	^ bitNo + shifted