C code generator
emitGlobalStructFlagOn: aStream
	"Depending upon the value of structDefDefine (See also #structDefDefine:), define SQ_USE_GLOBAL_STRUCT before including the header. Also derive the flag for using the global register; define USE_GLOBAL_STRUCT_REG to do so"

	aStream
		nextPutAll: '#if ';
		nextPutAll: structDefDefine; cr;
		nextPutAll: '# define SQ_USE_GLOBAL_STRUCT 1'; cr;
		nextPutAll: '#else'; cr;
		nextPutAll: '# define SQ_USE_GLOBAL_STRUCT 0'; cr;
		nextPutAll: '#endif'; cr;
		nextPutAll: '#if USE_GLOBAL_STRUCT_REG '; cr;
		nextPutAll: '# define SQ_USE_GLOBAL_STRUCT_REG 1'; cr;
		nextPutAll: '#else'; cr;
		nextPutAll: '# define SQ_USE_GLOBAL_STRUCT_REG 0'; cr;
		nextPutAll: '#endif'; cr;
		cr