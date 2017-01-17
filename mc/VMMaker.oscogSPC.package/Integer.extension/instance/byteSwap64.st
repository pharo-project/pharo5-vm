*VMMaker-bit manipulation
byteSwap64
	"swap the bytes of a 64 bit unsigned integer"
	
	^(((self << 56) bitAnd: 16rFF00000000000000) bitOr:
	  (((self << 40) bitAnd: 16rFF000000000000) bitOr:
	  (((self << 24) bitAnd: 16rFF0000000000) bitOr:
	  (((self << 8) bitAnd: 16rFF00000000) bitOr:
	  (((self >> 8) bitAnd: 16rFF000000) bitOr:
	  (((self >> 24) bitAnd: 16rFF0000) bitOr:
	  (((self >> 40) bitAnd: 16rFF00) bitOr:
	  ((self >> 56) bitAnd: 16rFF))))))))