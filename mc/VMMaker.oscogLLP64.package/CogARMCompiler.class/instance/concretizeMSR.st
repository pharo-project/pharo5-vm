generate machine code - concretize
concretizeMSR
	"Generate an MSR CPSR_f, #flags instruction.
Note that we only have business with the NZCV flags so we use
N -> 8
Z -> 4
C -> 2
V -> 1.
You don't want to mess with this too much."
	|  flags |
	flags := operands at: 0.
	self machineCodeAt: 0 put: (self msr: flags).
	^machineCodeSize := 4