Instances of the receiver hold the per-thread state of a call-out.

long *argVector		pointer to the start of the alloca'ed argument marshalling area
long *currentArg		pointer to the position in argVector to write the current argument
long *limit			the limit of the argument marshalling area (for bounds checking)
structReturnSize		the size of the space allocated for the structure return, if any
callFlags			the value of the ExternalFunctionFlagsIndex field in the ExternalFunction being called
ffiArgSpec et al		type information for the current argument being marshalled
stringArgIndex		the count of temporary strings used for marshalling Smalltalk strings to character strings.
stringArgs			pointers to the temporary strings used for marshalling Smalltalk strings to character strings.