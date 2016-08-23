transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound.
	 Attempt to constant-fold and answer a constant node commented with the original expression.
	 Commenting with the original expression is important because it allows us to detect shared cases.
	 e.g. currentBytecode bitAnd: 15 is the same in case 1 and case 17, but '1 /* 1 bitAnd: 15 */' differs
	 from '1 /* 17 bitAnd: 15 */', whereas '1 /* currentBytecode bitAnd: 15 */' doesn't change."
	| newReceiver newArguments |
	"Constant-fold shiftForWord, but not BytesPerWord"
	((VMBasicConstants mostBasicConstantSelectors includes: selector)
	 and: [(codeGen isBuiltinSelector: selector) not]) ifTrue:
		[codeGen isConstantNode: self valueInto:
			[:val|
			 ^TConstantNode new
				setValue: val;
				yourself]].
	newReceiver := receiver bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	newArguments := arguments collect: [:a| a bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	(newReceiver = receiver
	 and: [newArguments = arguments]) ifTrue:
		[^self].
	(constantFold
	 and: [newReceiver isConstant and: [newReceiver value isInteger]
	 and: [(newArguments allSatisfy: [:ea| ea isConstant and: [ea value isInteger]])
	 and: [codeGen isBuiltinSelector: selector]]]) ifTrue:
		[| value |
		value := [newReceiver value perform: selector withArguments: (newArguments collect: [:ea| ea value])]
					on: Error
					do: [:ea| nil].
		 (value isInteger
		 or: [value == true
		 or: [value == false]]) ifTrue:
			[^TConstantNode new
				setValue: value;
				"We assume Message prints its keywords and arguments interleaved.
				 e.g. that (Message selector: #between:and: arguments: #(0 1)) printString = 'between: 0 and: 1'"
				comment: (receiver isLeaf
								ifTrue: [receiver printString]
								ifFalse: ['(', receiver printString, ')']),
							' ',
							(Message selector: selector arguments: (arguments collect: [:ea| ea value])) printString;
				yourself]].
	^self shallowCopy
		receiver: newReceiver;
		arguments: newArguments;
		yourself
		