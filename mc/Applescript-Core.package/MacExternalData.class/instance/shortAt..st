accessing
shortAt: anInteger

	| loc offset |
	loc := ((anInteger-1) // 2) + 1.
	offset := 32 - (16*((anInteger-1) \\ 2)).
	^ ((self at: loc) >> offset) bitAnd: 16rFFFF
