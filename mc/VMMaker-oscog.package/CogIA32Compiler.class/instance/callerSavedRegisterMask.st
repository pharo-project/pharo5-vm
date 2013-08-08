accessing
callerSavedRegisterMask
	^cogit
		registerMaskFor: (self abstractRegisterForConcreteRegister: EAX)
		and: (self abstractRegisterForConcreteRegister: ECX)
		and: (self abstractRegisterForConcreteRegister: EDX)