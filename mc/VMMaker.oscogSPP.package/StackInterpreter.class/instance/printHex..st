debug printing
printHex: n
	"Print n in hex,  in the form '    0x1234', padded to a width of 10 characters
	 in 32-bits ('0x' + 8 nibbles) or 18 characters in 64-bits ('0x' + 16 nibbles)"
	<api>
	| len buf |
	<var: #buf declareC: 'char buf[37]'> "large enough for a 64-bit value in hex plus the null plus 16 spaces"
	self cCode: 'memset(buf,'' '',36)' inSmalltalk: [buf := 'doh!'].
	len := self cCode: 'sprintf(buf + 2 + 2 * BytesPerWord, "0x%" PRIxSQPTR, (usqIntptr_t)(n))'.
	self cCode: 'printf("%s", buf + len)'.
	len touch: buf