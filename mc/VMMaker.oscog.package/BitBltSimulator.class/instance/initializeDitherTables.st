simulation
initializeDitherTables
	ditherMatrix4x4 := CArrayAccessor on:
		#(	0	8	2	10
			12	4	14	6
			3	11	1	9
			15	7	13	5).
	ditherThresholds16 := CArrayAccessor on:#(0 2 4 6 8 10 12 14 16).
	ditherValues16 := CArrayAccessor on: 
		#(0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30).
	dither8Lookup := CArrayAccessor on: (Array new: 4096).