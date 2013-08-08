accessing
byteAt: anInteger

	| loc offset |
	loc := ((anInteger-1) // 4) + 1.
	offset := 24 - (8*((anInteger-1) \\ 4)).
	^ ((self at: loc) >> offset) bitAnd: 16rFF
