in-line cacheing
compileClosedPICPrototype
	"Compile the abstract instructions for a full closed PIC, used to generate the chunk of code
	 which is copied to form each closed PIC.  A Closed Polymorphic Inline Cache is a small jump
	 table used to optimize sends with a limited degree of polymorphism (currently up to 6 cases).
	 We call it closed because it deals only with a finite number of cases, as opposed to an Open PIC.
	 When a monomorphic linked send (a send with a single case, linking direct to the checked entry
	 point of a CogMethod) fails a class check, the Cogit attempts to create a two-entry PIC that will
	 handle jumping to the original target for the original class and the relevant target for the new
	 class.  This jump table will be extended on subsequent failures up to a limit (6).

	 We avoid extending CPICs to Open PICs by linking the send site to an Open PIC if one already
	 exists with the send's selector, a good policy since measurements show that sends of mega-
	 morphic selectors usually become megamorphic at all send sites.  Hence the Open PIC list.

	 A CPIC also optimizes MNUs and interpret-only methods.  Each case can load SendNumArgs with
	 the oop of a method, or will load SendNumArgs with 0 if not.  MNUs are optimized by jumping to
	 the mnuAbort in the CPIC, which calls code that creates the Message, thereby avoiding looking up
	 the original message which will not be found, and either looks up doesNotUnderstand: or directly
	 activates the method loaded into SendNumArgs, hence avoiding looking up doesNotUnderstand:.
	 Interpret-only methods are handled by jumping to the picInterpretAbort, which enters the
	 interpreter activating the method loaded in SendNumArgs.

	 CPICs look like the following, where rClass is set at the original send site for the 1st case, and #Foo
	 is some constant, either an oop, a class tag or an instruction address.

		rTemp := (rRecever bitAnd: TagMask) = 0 ifTrue: [rReceiver class] ifFalse: [rRecever bitAnd: TagMask].
		rTemp = rClass ifFalse:
			[self goto: #Label].
		rSendNumArgs := #MethodForCase1Or0.
		self goto: #TargetForCase1.
	 #Label
		rTemp = #ClassTagForCase6 ifTrue:
			[rSendNumArgs := #MethodForCase6Or0.
			 self goto: #TargetForCase6].
		...cases 5, 4 & 3
		rTemp = #ClassTagForCase2 ifTrue:
			[rSendNumArgs := #MethodForCase2Or0.
			 self goto: #TargetForCase2].
		self goto: #CPICMissTrampoline
		literals (if out-of-line literals)

	 where we short-cut as many cases as needed by making the self goto: #Label skip as many cases
	 as needed."
	<inline: true>
	| numArgs jumpNext |
	<var: #jumpNext type: #'AbstractInstruction *'>
	self compilePICAbort: (numArgs := 0). "Will get rewritten to appropriate arity when configuring."
	jumpNext := self compileCPICEntry.
	"At the end of the entry code we need to jump to the first case code, which is actually the last chunk.
	 On each entension we must update this jump to move back one case."
	"16r5EAF00D is the method oop, or 0, for the 1st case."
	self MoveUniqueCw: 16r5EAF00D R: SendNumArgsReg.
	self JumpLong: self cPICPrototypeCaseOffset + 16rCA5E10.
	endCPICCase0 := self Label.
	1 to: MaxCPICCases - 1 do:
		[:h|
		h = (MaxCPICCases - 1) ifTrue:
			[jumpNext jmpTarget: self Label]. "this is where we jump to for the first case"
		"16rBADA550+h is the method oop, or 0, for the Nth case."
		self MoveUniqueCw: 16rBADA550 + h R: SendNumArgsReg.
		"16rBABE1F15+h is the class tag for the Nth case"
		self CmpC32: 16rBABE1F15+h R: TempReg.
		self JumpLongZero: self cPICPrototypeCaseOffset + 16rCA5E10 + (h * 16).
		h = 1 ifTrue:
			[endCPICCase1 := self Label]].
	self MoveCw: methodLabel address R: ClassReg.
	self JumpLong: (self cPICMissTrampolineFor: numArgs).	"Will get rewritten to appropriate arity when configuring."
	cPICEndOfCodeLabel := self Label.
	literalsManager dumpLiterals: false.
	^0