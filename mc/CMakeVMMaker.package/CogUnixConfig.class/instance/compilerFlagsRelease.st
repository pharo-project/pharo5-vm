compiler flags
compilerFlagsRelease
"
THIS FLAGS ARE CRASHING COMPILER 
-fschedule-insns2 
-fschedule-insns 

THIS FLAGS ARE CRASHING VM
-ftree-pre  
-fcaller-saves 

THIS FLAGS ARE WORKING 
-O1 -fthread-jumps -falign-functions -falign-jumps -falign-loops -falign-labels -fcrossjumping -fcse-follow-jumps -fcse-skip-blocks -fdelete-null-pointer-checks -fdevirtualize -fexpensive-optimizations -fgcse -fgcse-lm -finline-small-functions -findirect-inlining -fipa-sra -foptimize-sibling-calls -fpeephole2 -fregmove -freorder-blocks -frerun-cse-after-loop -freorder-functions  -fsched-interblock -fsched-spec -fstrict-aliasing -fstrict-overflow  -ftree-switch-conversion -ftree-vrp

THIS IS LIKE: -O2 -fno-tree-pre -fno-caller-saves 

"

	^ {
		'-g0'. 
		'-O2'. 
		'-fno-tree-pre'. 
		'-fno-caller-saves'. 
		'-msse2'. 
		'-D_GNU_SOURCE'. 
		'-DNDEBUG'. 
		'-DITIMER_HEARTBEAT=1'. 
		'-DNO_VM_PROFILE=1'. 
		'-DDEBUGVM=0' }