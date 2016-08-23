disassembly
codeRangesFor: cogMethod
	"Answer a sequence of ranges of code for the main method and all of the blocks in a CogMethod.
	 N.B.  These are in order of block dispatch, _not_ necessarily address order in the method."
	<doNotGenerate>
	| pc end blockEntry starts |
	cogMethod cmType = CMClosedPIC ifTrue:
		[end := cogMethod asInteger + cPICEndOfCodeOffset - backEnd jumpLongByteSize.
		 ^{ CogCodeRange
				from: cogMethod asInteger + (self sizeof: CogMethod)
				to: end
				cogMethod: cogMethod
				startpc: nil }].
	end := (self mapEndFor: cogMethod) - 1.
	cogMethod blockEntryOffset = 0 ifTrue:
		[^{ CogCodeRange
				from: cogMethod asInteger + (self sizeof: CogMethod)
				to: end
				cogMethod: cogMethod
				startpc: (cogMethod cmType ~= CMOpenPIC ifTrue:
							[coInterpreter startPCOfMethodHeader: cogMethod methodHeader]) }].
	pc := blockEntry := cogMethod blockEntryOffset + cogMethod asInteger.
	starts := OrderedCollection with: cogMethod.
	[pc < end] whileTrue:
		[| targetpc |
		 targetpc := blockEntry.
		 (backEnd isJumpAt: pc) ifTrue:
			[targetpc := backEnd jumpTargetPCAt: pc.
			 targetpc < blockEntry ifTrue:
				[starts add: (self cCoerceSimple: targetpc - (self sizeof: CogBlockMethod) to: #'CogBlockMethod *')]].
		 pc := pc + (backEnd instructionSizeAt: pc)].
	starts := starts asSortedCollection.
	^(1 to: starts size + 1) collect:
		[:i| | cogSubMethod nextpc |
		i <= starts size
			ifTrue:
				[cogSubMethod := starts at: i.
				 nextpc := i < starts size ifTrue: [(starts at: i + 1) address] ifFalse: [blockEntry].
				 CogCodeRange
					from: cogSubMethod address + (self sizeof: cogSubMethod)
					to: nextpc - 1
					cogMethod: cogSubMethod
					startpc: (i = 1
								ifTrue: [coInterpreter startPCOfMethodHeader: cogMethod methodHeader]
								ifFalse: [cogSubMethod startpc])]
			ifFalse:
				[CogCodeRange
					from: blockEntry
					to: end]]