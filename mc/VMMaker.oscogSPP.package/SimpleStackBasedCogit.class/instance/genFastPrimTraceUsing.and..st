primitive generators
genFastPrimTraceUsing: r1 and: r2
	"Suport for compileInterpreterPrimitive.  Generate inline code so as to record the primitive
	 trace as fast as possible."
	backEnd byteReadsZeroExtend ifFalse:
		[self MoveCq: 0 R: r2].
	self MoveAb: coInterpreter primTraceLogIndexAddress R: r2.
	self MoveR: r2 R: r1.
	self AddCq: 1 R: r1.
	self MoveR: r1 Ab: coInterpreter primTraceLogIndexAddress.
	methodLabel addDependent:
		(self annotateAbsolutePCRef:
			(self MoveCw: methodLabel asInteger R: r1)).
	self MoveMw: (self offset: CogMethod of: #selector) r: r1 R: TempReg.
	self MoveCw: coInterpreter primTraceLogAddress asInteger R: r1.
	self MoveR: TempReg Xwr: r2 R: r1