combination rules
pixSwap: sourceWord with: destWord
	"Swap the pixels in destWord"
	| result shift lowMask highMask |
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destWord type: 'unsigned int'>
	<var: #lowMask type: 'unsigned int'>
	<var: #highMask type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	destPPW = 1 ifTrue:[^destWord]. "a single pixel per word"
	result := 0.
	lowMask := (1 << destDepth) - 1. "mask low pixel"
	highMask := lowMask << (destPPW-1 * destDepth). "mask high pixel"
	shift := 32 - destDepth.
	result := result bitOr: (
				(destWord bitAnd: lowMask) << shift bitOr:
					(destWord bitAnd: highMask) >> shift).
	destPPW <= 2 ifTrue:[^result].
	2 to: destPPW // 2 do:[:i|
		lowMask := lowMask << destDepth.
		highMask := highMask >> destDepth.
		shift := shift - (destDepth * 2).
		result := result bitOr: (
					(destWord bitAnd: lowMask) << shift bitOr:
						(destWord bitAnd: highMask) >> shift)].
	^result