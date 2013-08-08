utils
fixLibsTemplate

^
'include(GetPrerequisites)

message("Fixing library references in: ${externalModulesDir}")

FILE(GLOB libs  "${externalModulesDir}/*.dylib")

set(all_imports "")

foreach(lib ${libs})
	get_filename_component(libName "${lib}" NAME)
	list(APPEND libNames "${libName}")
	
	set(prereq "")
	get_prerequisites(${lib} prereq 1 0 "${bundlePath}" "")


	list(APPEND all_imports ${prereq})

endforeach(lib)

list(REMOVE_DUPLICATES all_imports)
set(replacements "")
message ( "Found imports: ${all_imports} " )

foreach(import ${all_imports})
	foreach(lib ${libNames})
		set(match "^.*${lib}$")
		if(import MATCHES ${match})
			set(replacement "${pluginsRelPath}/${lib}")
			message("Will replace: ${import} with: ${replacement}")
			set(replacements ${replacements} "-change" "${import}" "${replacement}")
		endif(import MATCHES ${match})
	endforeach(lib)
endforeach(import)

foreach(lib ${libs})
	get_filename_component(name ${lib} NAME)
	set(fixedName "${pluginsRelPath}/${name}")
	message("Fixing up: ${name}")

 	execute_process(COMMAND install_name_tool -id "${fixedName}" "${lib}" )

 	execute_process(COMMAND install_name_tool  ${replacements} ${lib} )

endforeach(lib)
'

