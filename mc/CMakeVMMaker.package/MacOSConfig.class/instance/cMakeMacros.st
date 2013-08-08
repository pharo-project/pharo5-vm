accessing
cMakeMacros 
	^'macro(add_framework appname fwname)
    find_library(FRAMEWORK_${fwname}
        NAMES ${fwname}
        PATHS ${CMAKE_OSX_SYSROOT}/System/Library
        PATH_SUFFIXES Frameworks
        NO_DEFAULT_PATH)
    if( ${FRAMEWORK_${fwname}} STREQUAL FRAMEWORK_${fwname}-NOTFOUND)
        message(ERROR ": Framework ${fwname} not found")
    else()
	  include_directories(SYSTEM /System/Library/Frameworks/${fwname}.framework/Headers)
	  target_link_libraries(${appname} ${FRAMEWORK_${fwname}})
    endif()
endmacro(add_framework)'  