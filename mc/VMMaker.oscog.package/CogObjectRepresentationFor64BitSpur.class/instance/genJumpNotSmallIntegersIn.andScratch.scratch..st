compile abstract instructions
genJumpNotSmallIntegersIn: aRegister andScratch: scratchA scratch: scratchB
	"Generate a compare and branch to test if aRegister and scratchA contains other than SmallIntegers,
	 i.e. don't branch if both aRegister and scratchA contain SmallIntegers.
	 Answer the jump.  Destroy scratchA and scratchB if required."
	<returnTypeC: #'AbstractInstruction *'>
	"Straight-forward approach.  Map SmallIntegers to 0 in scratchA & scratchB, add and jump non-zero."
	cogit backEnd hasThreeAddressArithmetic
		ifFalse:
			[^cogit
				MoveR: aRegister R: scratchB;
				SubCq: objectMemory smallIntegerTag R: scratchA;
				SubCq: objectMemory smallIntegerTag R: scratchB;
				AndCq: objectMemory tagMask R: scratchA;
				AndCq: objectMemory tagMask R: scratchB;
				AddR: scratchA R: scratchB;
				JumpNonZero: 0]
	"Better approach; iff 3 address arithmetic.  Because tag pattern 7 is unused the following selects only two SmallIntegers
		| pairs |
		pairs := OrderedCollection new.
		0 to: 7 do: [:r| 0 to: 7 do: [:a| pairs addLast: {r. a}]].
		pairs select: [:p| ([:r :a| (a - r bitAnd: 7) + a] valueWithArguments: p) = 1]
			=>  an OrderedCollection(#(1 1) #(7 0))
			But if there is no three address arithmetic this also generates 7 instructions."
		ifTrue:
			[^cogit
				AndCq: objectMemory tagMask R: scratchA R: scratchB;
				SubR: aRegister R: scratchA;
				AndCq: objectMemory tagMask R: scratchA;
				AddCq: objectMemory smallIntegerTag negated R: scratchB R: scratchA;
				JumpNonZero: 0]