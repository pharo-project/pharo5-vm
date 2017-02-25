code generation
offsetForInstVar: instVarName
	"Hack to offset accesses to variables by certain values.  The inst vars following
	 the objectHeader must be offset by the baseHeaderSize."
	^(#('objectHeader' 'homeOffset' 'startpc' 'padToWord') includes: instVarName) ifFalse:
		['baseHeaderSize']