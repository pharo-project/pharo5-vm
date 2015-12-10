private
leftRotate: anInteger by: bits
	"Rotate the given 32-bit integer left by the given number of bits and answer the result."

	<var: #anInteger type: 'unsigned int'>

	^ (anInteger << bits) bitOr: (anInteger >> (32 - bits))
