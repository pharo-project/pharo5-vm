stack bytecodes
remoteIsInstVarAccess
	"If this byte is set in the second byte (zero-based) of the instruction, 
	the remote temp instruction is in fact a remote inst var access"
	<api>
	<cmacro>
	^ 128 "1 << 7"