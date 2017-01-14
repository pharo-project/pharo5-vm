abstract instructions
genSubstituteReturnAddress: retpc
	"Fake the return address for a call/jump so that the ``call'' returns
	 to retpc given that the ``call'' will be made by a following jump."
	self subclassResponsibility