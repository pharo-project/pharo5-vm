test support
testDisassembleMethodsFor: aBehavior
	aBehavior selectors asArray sort do:
		[:sel| | method |
		method := aBehavior compiledMethodAt: sel.
		self shouldnt: [BytecodeDisassembler new disassemble: method]
			raise: Error]