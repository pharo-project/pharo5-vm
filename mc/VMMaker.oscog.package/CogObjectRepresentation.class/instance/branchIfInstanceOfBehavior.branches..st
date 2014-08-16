sista support
branchIfInstanceOfBehavior: classObj branches: branches
	"Generate a branch if ReceiverResultReg is an instance of classObj, otherwise fall-
	 through. Store the branch in branches and answer the number of branches generated."
	<var: #branches type: #'AbstractInstruction **'>
	self subclassResponsibility