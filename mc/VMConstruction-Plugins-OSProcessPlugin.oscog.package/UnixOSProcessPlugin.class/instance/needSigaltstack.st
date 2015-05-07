private - sigaltstack
needSigaltstack
	"Answer if the plugin should use a signalstack to avoid delivering signals
	 on the native stack, which can interfere with the JIT.  As a side-effect,
	 allocate one if one is not already available.  We use GetAttributeString
	 to detect the JIT, and if so detected we use a signalstack,  We reuse
	 any existing signalstack if available."
	| GetAttributeString sigstack SigStackSize |
	<var: 'GetAttributeString' declareC: 'char * (*GetAttributeString)(int)'>
	<var: 'sigstack' declareC: 'stack_t sigstack = {0}'>
	useSignalStack >= 0 ifTrue:
		[^useSignalStack ~= 0].
	GetAttributeString := interpreterProxy ioLoadFunction: 'GetAttributeString' From: 'os_exports'.
	(GetAttributeString = nil "1008 is the Cogit buildInfo string"
	 or: [(self cCode: 'GetAttributeString(1008)' inSmalltalk: [nil]) = nil]) ifTrue:
		[useSignalStack := 0.
		 ^false].
	useSignalStack := 1.
	"Now see if there's already a sigaltstack in place"
	(self cCode: 'sigaltstack(0,&sigstack)' inSmalltalk: [0]) < 0 ifTrue:
		[self perror: 'sigaltstack'].

	self cppIf: #'SA_DISABLE' defined
		ifTrue:
			[(self cCode: 'sigstack.ss_size == 0 || (sigstack.ss_flags & SA_DISABLE)'
					inSmalltalk: [self touch: (sigstack := nil)]) ifFalse:
				[^true]]
		ifFalse: "e.g. Mac OS documents SA_DISABLE but defines SS_DISABLE"
			[(self cCode: 'sigstack.ss_size == 0 || (sigstack.ss_flags & SS_DISABLE)'
					inSmalltalk: [self touch: sigstack]) ifFalse:
				[^true]].

	"16k words is also the ammount the ITimer heartbeat routines allocate."
	SigStackSize := 1024 * (self sizeof: #'void *') * 16 max: #MINSIGSTKSZ.
	nil = (self cCode: 'sigstack.ss_size = SigStackSize, sigstack.ss_sp = malloc(SigStackSize)'
			inSmalltalk: [self touch: SigStackSize]) ifTrue:
		[self msg: 'sigstack malloc failed'.
		 useSignalStack := 0.
		 ^false].
	(self cCode: 'sigaltstack(&sigstack, 0) < 0') ifTrue:
		[self msg: 'sigaltstack install failed'.
		 self cCode: '(void)free(sigstack.ss_sp)'.
		 useSignalStack := 0.
		 ^false].
	^true