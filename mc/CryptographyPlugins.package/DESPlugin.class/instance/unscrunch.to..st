support
unscrunch: wordPtr to: bytePtr
	<var: 'bytePtr' declareC: 'unsigned char *bytePtr'>
	<var: 'wordPtr' declareC: 'unsigned long *wordPtr'>
	bytePtr at: 0 put: (((wordPtr at: 0)>>24) bitAnd: 16rFF).
	bytePtr at: 1 put: (((wordPtr at: 0)>>16) bitAnd: 16rFF).
	bytePtr at: 2 put: (((wordPtr at: 0)>>8) bitAnd: 16rFF).
	bytePtr at: 3 put: ((wordPtr at: 0) bitAnd: 16rFF).
	bytePtr at: 4 put: (((wordPtr at: 1)>>24) bitAnd: 16rFF).
	bytePtr at: 5 put: (((wordPtr at: 1)>>16) bitAnd: 16rFF).
	bytePtr at: 6 put: (((wordPtr at: 1)>>8) bitAnd: 16rFF).
	bytePtr at: 7 put: ((wordPtr at: 1) bitAnd: 16rFF).
