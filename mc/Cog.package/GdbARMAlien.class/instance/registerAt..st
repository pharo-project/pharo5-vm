accessing
registerAt: index 
	^self perform: (self registerStateGetters at: index + 1)