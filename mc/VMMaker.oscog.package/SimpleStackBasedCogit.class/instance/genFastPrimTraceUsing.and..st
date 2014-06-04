primitive generators
genFastPrimTraceUsing: r1 and: r2
	"Suport for compileInterpreterPrimitive.  Generate inline code so as to record the primitive
	 trace as fast as possible."
	self MoveCq: 0 R: TempReg.
	self MoveCq: 0 R: r2. "N.B. MoveMb:r:R: does not zero other bits"
	self MoveMb: coInterpreter primTraceLogIndexAddress r: TempReg R: r2.
	self MoveR: r2 R: r1.
	self AddCq: 1 R: r1.
	self MoveR: r1 Mb: coInterpreter primTraceLogIndexAddress r: TempReg.
	methodLabel addDependent:
		(self annotateAbsolutePCRef:
			(self MoveCw: methodLabel asInteger R: r1)).
	self MoveMw: (self offset: CogMethod of: #selector) r: r1 R: TempReg.
	self MoveCw: coInterpreter primTraceLogAddress asInteger R: r1.
	self MoveR: TempReg Xwr: r2 R: r1