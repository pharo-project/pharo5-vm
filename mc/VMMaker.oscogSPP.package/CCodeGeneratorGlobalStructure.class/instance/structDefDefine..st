initialize-release
structDefDefine: aString
"set the string that will appear in the C file to define whether or not to use the global struct; reasonable values would be:
'USE_GLOBAL_STRUCT' - which would be defined in a header or makefile
'0' - which would mean never do it
'1' - which would mean always do it"
	structDefDefine := aString