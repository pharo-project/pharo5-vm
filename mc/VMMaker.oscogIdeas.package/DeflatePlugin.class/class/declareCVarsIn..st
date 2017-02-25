translation
declareCVarsIn: cg
	super declareCVarsIn: cg. "Required since we share some instVars"
	cg var: #zipHashHead type: #'unsigned int*'.
	cg var: #zipHashTail type: #'unsigned int*'.
	cg var: #zipLiterals type: #'unsigned char*'.
	cg var: #zipDistances type: #'unsigned int*'.
	cg var: #zipLiteralFreq type: #'unsigned int*'.
	cg var: #zipDistanceFreq type: #'unsigned int*'.
	cg var: #zipMatchLengthCodes type: #'unsigned int' array: ZipWriteStream matchLengthCodes.
	cg var: #zipDistanceCodes type: #'unsigned int' array: ZipWriteStream distanceCodes.
	cg var: #zipCrcTable type: #'unsigned int' array: GZipWriteStream crcTable.
	cg var: #zipExtraLengthBits type: #'unsigned int' array: ZipWriteStream extraLengthBits.
	cg var: #zipExtraDistanceBits type: #'unsigned int' array: ZipWriteStream extraDistanceBits.
	cg var: #zipBaseLength type: #'unsigned int' array: ZipWriteStream baseLength.
	cg var: #zipBaseDistance type: #'unsigned int' array: ZipWriteStream baseDistance