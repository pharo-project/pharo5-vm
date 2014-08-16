sista support
branchIfInstanceOfBehaviors: arrayObj branches: branches
	"Generate a branch if ReceiverResultReg is an instance of any of the classes in arrayObj,
	 otherwise fall-through. Store the branch in branches and answer the number of branches
	 generated."
	<var: #branches type: #'AbstractInstruction **'>
	self subclassResponsibility