accessing
cResultRegister
	"Answer the abstract register for the C result register.
	 Only partially implemented (there is as yet no CResultReg abstract reg).
	 Works on x86 since TempReg = EAX = C result reg."
	self subclassResponsibility