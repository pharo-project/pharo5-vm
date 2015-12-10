support
scrunch: bytePtr to: wordPtr
	<var: 'bytePtr' declareC: 'unsigned char *bytePtr'>
	<var: 'wordPtr' declareC: 'unsigned long *wordPtr'>
	wordPtr at: 0 put:
		(bytePtr at: 0) << 24 +
		((bytePtr at: 1) << 16) +
		((bytePtr at: 2) << 8) +
		(bytePtr at: 3).
	wordPtr at: 1 put:
		(bytePtr at: 4) << 24 +
		((bytePtr at: 5) << 16) +
		((bytePtr at: 6) << 8) +
		(bytePtr at: 7)