initialization
initializeCompilerHooks
	"Interpreter initializeCompilerHooks"

	"compilerHooks[] indices:
	1	void compilerTranslateMethodHook(void)
	2	void compilerFlushCacheHook(CompiledMethod *oldMethod)
	3	void compilerPreGCHook(int fullGCFlag)
	4	void compilerMapHook(int memStart, int memEnd)
	5	void compilerPostGCHook(void)
	6	void compilerProcessChangeHook(void)
	7	void compilerPreSnapshotHook(void)
	8	void compilerPostSnapshotHook(void)
	9	void compilerMarkHook(void)
	10	void compilerActivateMethodHook(void)
	11	void compilerNewActiveContextHook(int sendFlag)
	12	void compilerGetInstructionPointerHook(void)
	13	void compilerSetInstructionPointerHook(void)
	14	void compilerCreateActualMessageHook(void)"

	CompilerHooksSize := 15.