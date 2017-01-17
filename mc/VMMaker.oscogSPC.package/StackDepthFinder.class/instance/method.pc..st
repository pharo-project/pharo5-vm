private
method: method pc: startpc
	super method: method pc: startpc.
	"The + 1 is there for full blocks ending with non local return,
	as the following pc is mapped and beyong endPC"
	joins := Array new: method endPC + 1.
	stackp := method numTemps.
	deadCode := false