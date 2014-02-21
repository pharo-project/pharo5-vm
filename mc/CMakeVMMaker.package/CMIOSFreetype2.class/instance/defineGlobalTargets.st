generating actions
defineGlobalTargets
	| var |
	var := self canonicalName , '_LIB'.
	vmGen set: var toString: self libraryFileName.
"
define a library as imported one
and make it depend from it's build target
"

	vmGen
		puts: 
('add_library("\{{1}\}" STATIC IMPORTED GLOBAL)
	set_target_properties("\{{1}\}" PROPERTIES IMPORTED_LOCATION "\{{1}\}")
add_dependencies("\{{1}\}" "{2}")
' format: { var. self buildTarget }
).

	vmGen cmd: 'add_dependencies' params:
		vmGen moduleName , ' ' , self buildTarget