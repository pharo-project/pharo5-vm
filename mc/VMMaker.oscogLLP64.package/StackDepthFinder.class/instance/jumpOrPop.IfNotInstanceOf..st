instruction decoding
jumpOrPop: delta IfNotInstanceOf: behaviors
	"Conditional Jump bytecode."
	self doJump: delta.
	self drop.