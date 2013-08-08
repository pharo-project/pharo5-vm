accessing
nfib
	"long fib(long n) { return n <= 1 ? 1 : fib(n-1) + fib(n-2) + 1; }
	 as compiled by Microsoft Visual C++ V6 (12.00.8804) cl /O2 /Fc"
	"| bat nfib ip |
	bat := BochsIA32AlienTests new.
	nfib := bat nfib asByteArray.
	ip := 0.
	20 timesRepeat:
		[bat processor disassembleInstructionAt: ip In: nfib into:
			[:da :len|
			Transcript nextPutAll: da; cr; flush.
			ip := ip + len]]"
	^#("00000" 16r56							"push    esi"
		"00001" 16r8B 16r74 16r24 16r08		"mov     esi, DWORD PTR _n$[esp]"
		"00005" 16r83 16rFE 16r01				"cmp     esi, 1"
		"00008" 16r7F 16r07						"jg      SHORT $L528"
		"0000a" 16rB8 16r01 16r00 16r00 16r00	"mov     eax, 1"
		"0000f" 16r5E							"pop     esi"
		"00010" 16rC3							"ret     0"
"
$L528:"
		"00011" 16r8D 16r46 16rFE				"lea     eax, DWORD PTR [esi-2]"
		"00014" 16r57							"push    edi"
		"00015" 16r50							"push    eax"
		"00016" 16rE8 16rE5 16rFF 16rFF 16rFF   "call    _fib"
		"0001b" 16r4E							"dec     esi"
		"0001c" 16r8B 16rF8						"mov     edi, eax"
		"0001e" 16r56							"push    esi"
		"0001f" 16rE8 16rDC 16rFF 16rFF 16rFF   "call    _fib"
		"00024" 16r83 16rC4 16r08				"add     esp, 8"
		"00027" 16r8D 16r44 16r07 16r01		"lea     eax, DWORD PTR [edi+eax+1]"
		"0002b" 16r5F							"pop     edi"
		"0002c" 16r5E							"pop     esi"
		"0002d" 16rC3							"ret     0")