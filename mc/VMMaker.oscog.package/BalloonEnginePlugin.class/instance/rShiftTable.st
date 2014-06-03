private
rShiftTable
	| theTable |
	<returnTypeC:'int *'>
	<inline: false>
	<var:#theTable declareC:'static int theTable[17] =
		{0, 5, 4, 0, 3, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1}'>
	^theTable