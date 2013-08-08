C core util
cCopyIntVal: val toBytes: bytes 
	| pByte |
	<var: #pByte type: 'unsigned char *  '>
	pByte := interpreterProxy firstIndexableField: bytes.
	1 to: (self cDigitLengthOfCSI: val)
		do: [:ix | pByte at: ix - 1 put: (self cDigitOfCSI: val at: ix)]