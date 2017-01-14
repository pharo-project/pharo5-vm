disassembly
allCogMethodsFor: cogMethod
	<doNotGenerate>
	| blockEntry end methods pc |
	cogMethod isInteger ifTrue: [^self allCogMethodsFor: (self cogMethodSurrogateAt: cogMethod)].
	cogMethod cmType = CMBlock ifTrue:
		[^self allCogMethodsFor: cogMethod cmHomeMethod].
	(cogMethod cmType ~= CMMethod
	 or: [cogMethod blockEntryOffset = 0]) ifTrue:
		[^{cogMethod}].

	methods := OrderedCollection with: cogMethod.
	pc := blockEntry := cogMethod blockEntryOffset + cogMethod asInteger.
	end := (self mapEndFor: cogMethod) - 1.
	[pc < end] whileTrue:
		[| targetpc |
		 targetpc := blockEntry.
		 (backEnd isJumpAt: pc) ifTrue:
			[targetpc := backEnd jumpTargetPCAt: pc.
			 targetpc < blockEntry ifTrue:
				[methods add: (self cCoerceSimple: targetpc - (self sizeof: CogBlockMethod) to: #'CogBlockMethod *')]].
		 pc := pc + (backEnd instructionSizeAt: pc)].
	^methods sort