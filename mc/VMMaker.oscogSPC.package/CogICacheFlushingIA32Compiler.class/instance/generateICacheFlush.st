inline cacheing
generateICacheFlush
	"Use CPUID as a serializing instruction for instruction modification.
	 MFENCE doesn't work which is a shame because CPUID updates registers."
	cogit
		PushR: EDX;
		PushR: ECX;
		PushR: EBX;
		XorR: EAX R: EAX;
		gen: CPUID;
		PopR: EBX;
		PopR: ECX;
		PopR: EDX;
		RetN: 8 "pop from,to args"

	"self hasSSE2Instructions
		ifTrue:
			[cogit
				gen: MFENCE]
		ifFalse:
			[cogit
				PushR: EDX;
				PushR: ECX;
				PushR: EBX;
				XorR: EAX R: EAX;
				gen: CPUID;
				PopR: EBX;
				PopR: ECX;
				PopR: EDX].
	cogit RetN: 8 ``pop from,to args''"