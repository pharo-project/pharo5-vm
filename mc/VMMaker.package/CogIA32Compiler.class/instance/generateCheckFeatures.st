feature detection
generateCheckFeatures
	cogit
		PushR: EDX;
		PushR: ECX;
		PushR: EBX;
		MoveCq: 1 R: EAX;
		gen: CPUID;
		MoveR: EDX R: EAX;
		PopR: EBX;
		PopR: ECX;
		PopR: EDX;
		RetN: 0