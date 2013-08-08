private
method: method pc: startpc
	super method: method pc: startpc.
	joins := Array new: method endPC.
	stackp := method numTemps