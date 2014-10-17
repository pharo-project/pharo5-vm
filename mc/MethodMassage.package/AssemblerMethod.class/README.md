An AssemblerMethod is a holder for a sequence of literals and a sequence of instructions which can represent a disassembled method, or a method being assembled.  AssemblerMethod supports two modes of operation.

The first mode is transcription, CompiledMethod -> AssemblerMethod -> CompiledMethod.
e.g.
	| original "CompiledMethod"
	  assembler "AssemblerMethod"
	  replica "CompiledMethod" |
	original := Object >> #printOn:.
	assembler := original disassemble.
	replica := assembler assemble.
	self assert: original = replica

The second mode is to construct an AssemblerMethod and assemble it.  This mode is under construction s there is no short-hand support for assembly.  What is supported is AssemblerMethod -> executable string -> AssemblerMethod.
e.g.
	| original "CompiledMethod"
	  assembler "AssemblerMethod"
	  assemblerText "String"
	  replica "CompiledMethod" |
	original := Object >> #printOn:.
	assembler := original disassemble.
	assemblerText := assembler assemblerString.
	replica := (Compiler evaluate: assemblerText) assemble.
	self assert: original = replica

Instance Variables
	fixLabels:		<UndefinedObject|Boolean>
	flag:			<Boolean>
	frameSize:		<Integer>
	instructions:	<SequenceableCollection>
	literals:			<SequenceableCollection>
	methodClass:	<Behavior>
	numArgs:		<Integer>
	numTemps:		<Integer>
	primitive:		<Integer>
	signFlag:		<Boolean>
	trailer:			<CompiledMethodTrailer>

fixLabels
	- if nil, the AssemblerMethod is being used in transcription mode and branch offsets should be integers.
	  if a boolean then it indicates whether instructions contains one or more instructions that need their branches fixing up.

flag
	- the value of the method's header flag (see CompiledMethod>>flag)

frameSize
	- the size of the method's frame (see CompiledMethod>>frameSize)

instructions
	- the sequence of Message and LookupKey objects making up the method's instructions

literals
	- the sequence of objects making up the method's literals

methodClass
	- the target class for the method (see CompiledMethod>>methodClass)

numArgs
	- the method's argument count (see CompiledMethod>>numArgs)

numTemps
	- the method's temporary count (see CompiledMethod>>numTemps)

primitive
	- the method's primitive (see CompiledMethod>>primitive)

signFlag
	- the value of the method's signFlag (see CompiledMethod>>signFlag)

trailer
	- the method;s trailer (see CompiledMethod>>trailer)
