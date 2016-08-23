in-image compilation
genAndDis: methodOrDoitString options: optionsDictionaryOrArray
	| tuple |
	methodOrDoitString isCompiledMethod ifFalse:
		[^self
			genAndDis: (Compiler new
							compiledMethodFor: methodOrDoitString
							in: nil
							to: nil
							notifying: nil
							ifFail: nil
							logged: false)
			 options: optionsDictionaryOrArray].
	tuple := self cog: methodOrDoitString selectorOrNumCopied: methodOrDoitString selector options: optionsDictionaryOrArray.
	tuple second disassembleMethod: tuple last.
	^tuple