accessing
cResultRegister
	"Answer the abstract register for the C result register.
	 Only partially implemented.  Works on x64 since TempReg = RAX = C result reg."
	^self abstractRegisterForConcreteRegister: RAX