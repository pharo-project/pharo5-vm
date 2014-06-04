md5
rotate: value by: amount
	"Rotate value left by amount"
	| lowMask highMask |
	lowMask := (1 bitShift: 32-amount) - 1.
	highMask := 16rFFFFFFFF - lowMask.
	^((value bitAnd: lowMask) bitShift: amount) + 
		((value bitAnd: highMask) bitShift: amount-32)