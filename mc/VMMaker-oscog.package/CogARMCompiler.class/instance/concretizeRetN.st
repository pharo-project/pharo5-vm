generate machine code - concretize
concretizeRetN
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| offset |
	offset := operands at: 0.
	offset = 0 ifTrue:
		[self machineCodeAt: 0 put: 16rE8BD8000. "pop	{pc}"
		^machineCodeSize := 4].
	self assert: offset < 32. "We have an 8 bit immediate. If needed, we could rotate it less than 30 bit."
	self machineCodeAt: 0 put: 16rE28DDFFF. "add sp, sp, #n, 14"
	machineCode
		at: 0 put: offset. "no bit-mask needed, because of the assert"
	self machineCodeAt: 4 put: 16rE8BD8000.  "pop	{pc}"
	^machineCodeSize := 8