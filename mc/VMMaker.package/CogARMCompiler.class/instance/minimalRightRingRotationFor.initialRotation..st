encoding
minimalRightRingRotationFor: constant initialRotation: iniRightRingRotation
	"Given a constant and some initial rotation, tries to minimize that rotation in an effort to encode the according byte in constant. This is used, to encode the last 12bit of many operations, for which a 8bit immediate rotated by (2*)4bit is available. That immediate need be encoded with minimal rotation."
	| byte rightRingRotation |
	rightRingRotation := iniRightRingRotation.
		"Counter rotation to get the according byte. Because Smalltalk does not have left ring shift, shift further right."
		rightRingRotation ~= 0 ifTrue: [
			byte := constant >> (-2 * rightRingRotation + 32) bitAnd: 16rFF.
			"For 0, the shift has to be 0. For other immediates, the encoding with minimal rightRingRotation should be choosen."
			byte = 0
				ifTrue: [ rightRingRotation := 0]
				ifFalse: [
					0 to: 2 do: [ :j | 
						(byte bitAnd: 16r03) = 0
							ifTrue: [ rightRingRotation := rightRingRotation - 1.
									byte := byte >> 2 ]]]]
			ifFalse: [ byte := constant bitAnd: 16rFF].
	^{rightRingRotation. byte}