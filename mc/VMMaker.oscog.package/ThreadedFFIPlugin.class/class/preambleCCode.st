translation
preambleCCode
	"For a source of builtin defines grep for builtin_define in a gcc release config directory."
	^'
#include "sqAssert.h" /* for assert */
#define ThreadedFFIPlugin 1 /* to filter-out unwanted declarations from sqFFI.h */
#include "sqFFI.h" /* for logging and surface functions */

#ifdef _MSC_VER
# define alloca _alloca
#endif
#if defined(__GNUC__) && (defined(_X86_) || defined(i386) || defined(__i386) || defined(__i386__))
# define setsp(sp) asm volatile ("movl %0,%%esp" : : "m"(sp))
# define getsp() ({ void *esp; asm volatile ("movl %%esp,%0" : "=r"(esp) : ); esp;})
# elif defined(__GNUC__) && (defined(__amd64__) || defined(__x86_64__) ||  defined(__amd64) || defined(__x86_64))
# define setsp(sp) asm volatile ("movq %0,%%rsp" : : "m"(sp))
# define getsp() ({ void *rsp; asm volatile ("movq %%rsp,%0" : "=r"(rsp) : ); rsp;})
# elif defined(__GNUC__) && (defined(__arm__))
# define setsp(sp) asm volatile ("ldr %%sp, %0" : : "m"(sp))
# define getsp() ({ void *sp; asm volatile ("mov %0, %%sp" : "=r"(sp) : ); sp;})
#endif
#if !defined(getsp)
# define getsp() 0
#endif 
#if !defined(setsp)
# define setsp(ignored) 0
#endif 

#if !defined(STACK_ALIGN_BYTES)
# if __APPLE__ && __MACH__ && __i386__
#  define STACK_ALIGN_BYTES 16
# elif __linux__ && __i386__
#  define STACK_ALIGN_BYTES 16
# elif defined(__amd64__) || defined(__x86_64__) ||  defined(__amd64) || defined(__x86_64)
#  define STACK_ALIGN_BYTES 16
# elif defined(powerpc) || defined(__powerpc__) || defined(_POWER) || defined(__POWERPC__) || defined(__PPC__)
#  define STACK_ALIGN_BYTES 16
# elif defined(__sparc64__) || defined(__sparcv9__) || defined(__sparc_v9__) /* must precede 32-bit sparc defs */
#  define STACK_ALIGN_BYTES 16
# elif defined(sparc) || defined(__sparc__) || defined(__sparclite__)
#  define STACK_ALIGN_BYTES 8
# elif defined(__arm__) 
#  define STACK_ALIGN_BYTES 8
# else
#  define STACK_ALIGN_BYTES 0
# endif
#endif /* !defined(STACK_ALIGN_BYTES) */

#if !defined(STACK_OFFSET_BYTES)
# define STACK_OFFSET_BYTES 0
#endif

#if defined(_X86_) || defined(i386) || defined(__i386) || defined(__i386__)
/* Both Mac OS X x86 and Win32 x86 return structs of a power of two in size
 * less than or equal to eight bytes in length in registers. Linux never does so.
 */
# if __linux__
#	define WIN32_X86_STRUCT_RETURN 0
# else
#	define WIN32_X86_STRUCT_RETURN 1
# endif
# if WIN32
#	define PLATFORM_API_USES_CALLEE_POPS_CONVENTION 1
# endif
# elif defined(__amd64__) || defined(__x86_64__) ||  defined(__amd64) || defined(__x86_64)
# if WIN32 | WIN64
#	define PLATFORM_API_USES_CALLEE_POPS_CONVENTION 1
# endif
#endif /* defined(_X86_) || defined(i386) || defined(__i386) || defined(__i386__) */

#if !defined(ALLOCA_LIES_SO_USE_GETSP)
# if defined(__MINGW32__) && (__GNUC__ >= 3) && (defined(_X86_) || defined(i386) || defined(__i386) || defined(__i386__))
    /*
     * cygwin -mno-cygwin (MinGW) gcc 3.4.x''s alloca is a library routine that answers
     * %esp + 4, so the outgoing stack is offset by one word if uncorrected.
     * Grab the actual stack pointer to correct.
     */
#	define ALLOCA_LIES_SO_USE_GETSP 1
# else
#	define ALLOCA_LIES_SO_USE_GETSP 0
# endif
#endif /* !defined(ALLOCA_LIES_SO_USE_GETSP) */

#if !defined(PLATFORM_API_USES_CALLEE_POPS_CONVENTION)
# define PLATFORM_API_USES_CALLEE_POPS_CONVENTION 0
#endif

/* The dispatchOn:in:with:with: generates an unwanted call on error.  Just squash it. */
#define error(foo) 0
#ifndef SQUEAK_BUILTIN_PLUGIN
/* but print assert failures. */
void
warning(char *s) { /* Print an error message but don''t exit. */
	printf("\n%s\n", s);
}
#endif

/* sanitize */
#ifdef SQUEAK_BUILTIN_PLUGIN
# define EXTERN 
#else
# define EXTERN extern
#endif
'