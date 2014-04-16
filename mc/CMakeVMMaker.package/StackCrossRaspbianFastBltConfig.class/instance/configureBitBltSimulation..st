as yet unclassified
configureBitBltSimulation: maker
	"extra rules for BitBltSimulation"

	maker includeDirectories: '${pluginCross}'.
	maker set: 'can_use_assembler' to: 'TRUE'.
	maker cmd: 'enable_language' params: 'ASM'.
	maker set: 'CMAKE_ASM_COMPILE_OBJECT' to: '"asasm -cpu 6 -I ${pluginCross} -o <OBJECT> <SOURCE>"'.
	
	maker addCrossSources: #(
		'BitBltArm.c'
		'BitBltArmSimd.c'
		'BitBltDispatch.c'
		'BitBltGeneric.c'
		'BitBltArmLinux.c'
		'BitBltArmSimdAlphaBlend.s'
		'BitBltArmSimdBitLogical.s'
		'BitBltArmSimdPixPaint.s'
		'BitBltArmSimdSourceWord.s'
	).
	