translation
declareCVarsIn: cg
	cg var: 'yComponent'
		declareC: 'int yComponent[' , MinComponentSize printString , ']'.
	cg var: 'crComponent'
		declareC: 'int crComponent[' , MinComponentSize printString , ']'.
	cg var: 'cbComponent'
		declareC: 'int cbComponent[' , MinComponentSize printString , ']'.
	cg var: 'yBlocks'
		declareC: 'int *yBlocks[' , MaxMCUBlocks printString , ']'.
	cg var: 'crBlocks'
		declareC: 'int *crBlocks[' , MaxMCUBlocks printString  , ']'.
	cg var: 'cbBlocks'
		declareC: 'int *cbBlocks[' , MaxMCUBlocks printString  , ']'.
	cg var: 'residuals'
		declareC: 'int *residuals'.
	cg var: 'jpegBits'
		declareC: 'int *jpegBits'.

	cg var: 'jpegNaturalOrder'
		declareC: 'int jpegNaturalOrder[64] = {
	0, 1, 8, 16, 9, 2, 3, 10, 
	17, 24, 32, 25, 18, 11, 4, 5, 
	12, 19, 26, 33, 40, 48, 41, 34, 
	27, 20, 13, 6, 7, 14, 21, 28, 
	35, 42, 49, 56, 57, 50, 43, 36, 
	29, 22, 15, 23, 30, 37, 44, 51, 
	58, 59, 52, 45, 38, 31, 39, 46, 
	53, 60, 61, 54, 47, 55, 62, 63
}'.

	cg var: 'jsCollection' 
		declareC:'unsigned char *jsCollection'.
	cg var: 'acTable' 
		declareC:'int *acTable'.
	cg var: 'dcTable' 
		declareC:'int *dcTable'.
