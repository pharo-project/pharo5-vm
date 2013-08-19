settings
commonCompilerFlags 
	^ super commonCompilerFlags, #(
	'-fwrapv' "Non optimization of stackoverflow (to allow number conversions)"
	'-Wno-return-type' "to avoid clang to complain about plugins that do not return properly.")