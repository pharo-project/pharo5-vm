*VMMaker-bit manipulation
byteSwap32
	"swap the bytes of a 32 bit unsigned integer"
	
	^((self << 24) bitAnd: 16rFF000000) bitOr:
	  (((self << 8) bitAnd: 16rFF0000) bitOr:
	  (((self >> 8) bitAnd: 16rFF00) bitOr:
	  (((self >> 24) bitAnd: 16rFF))))