as yet unclassified
configureFloatMathPlugin: maker
	"extra rules for FloatMathPlugin"

	maker addCrossSources: #(
		'acos.c' 'acosh.c' 'asin.c' 'asinh.c' 'atan.c' 'atan2.c' 'atanh.c'
		'copysign.c' 'cos.c' 'cosh.c' 'exp.c' 'expm1.c' 'finite.c' 'fmod.c'
		'hypot.c' 'isnan.c' 'k_cos.c' 'k_rem_pio2.c' 'k_sin.c' 'k_tan.c' 'ldexp.c'
		'log.c' 'log10.c' 'log1p.c' 'modf.c' 'pow.c' 'rem_pio2.c' 'rint.c'
		'scalb.c' 'scalbn.c' 'sin.c' 'sinh.c' 'sqrt.c' 'tan.c' 'tanh.c' ).

	
	"according to http://www.netlib.org/fdlibm/readme
	it should be compiled with no optimizations
	# 3/25/11 - DSG Removed -mno-fused-madd
	since FreeBSD will not support > GCC42"
	maker addDefinitions: '-O0'.
	
	" compile with -D__LITTLE_ENDIAN
		This macro is set automatically in fdlibm.h when compiled ith -m32 but
		not when compiled with -m64 (Nicolas Cellier)
	"
	self isLittleEndian ifTrue: [
		maker addDefinitions: '-D__LITTLE_ENDIAN=1' ].
	
	"On *nix & mac with -DNO_ISNAN "
	maker puts:'
if (${WIN32})
	add_definitions(-Werror-implicit-function-declaration)	
else(${WIN32})
	add_definitions(-DNO_ISNAN)
endif (${WIN32})'.

