encoding
s: scale i: indexReg b: baseReg 
	^scale << 6 + ((indexReg bitAnd: 7) << 3) + (baseReg bitAnd: 7)