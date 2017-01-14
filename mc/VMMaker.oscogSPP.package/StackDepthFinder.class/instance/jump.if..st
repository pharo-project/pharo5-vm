instruction decoding
jump: delta if: condition 
	"Conditional Jump bytecode."
	self drop.
	self doJump: delta