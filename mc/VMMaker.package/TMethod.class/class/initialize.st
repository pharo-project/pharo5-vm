class initialization
initialize
	"TMethod initialize"	
	CaseStatements := IdentitySet new: 10.
	CaseStatements addAll: #(dispatchOn:in: dispatchOn:in:with: dispatchOn:in:with:with:).