bytecode generators
genUnoptimizedSpecialSelectorComparison
	"This method is there because if I put directly the super send in genSpecialSelectorComparison Slang does not correctly translte the code to C, it does not correctly type one of the branchDescriptor to BytecodeDescriptor"
	^ super genSpecialSelectorComparison