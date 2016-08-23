method map
mapEndFor: cogMethod
	"Answer the address of the null byte at the end of the method map."
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	| end |
	end := self mapStartFor: cogMethod.
	[(objectMemory byteAt: end) ~= MapEnd] whileTrue:
		[end := end - 1.
		 self assert: end > (self firstMappedPCFor: cogMethod)].
	^end