generating actions
download

	"Produce output to download library archive.
	By default, we use .tgz extension.. since it is most often used by OSS.
	Note, that we check if file is already present, to not download it every time
	we build"	
	
	gen puts:
'if (NOT EXISTS "${workDir}/${archiveFileName}")
	Message("Downloading  ',self fileServerURL,'${archiveFileName}")

	FILE(DOWNLOAD
		', self fileServerURL , self archiveFileName ,'
	 	"${workDir}/${archiveFileName}"
		STATUS downloadStatus
		SHOW_PROGRESS
	)
	
	LIST(GET downloadStatus 0 downloadError)
	if (NOT downloadError EQUAL 0)
		Message("File is missing on file server (', self fileServerURL,'), downloading from official repository...")
		FILE(DOWNLOAD
			${url}
		 	"${workDir}/${archiveFileName}"
			STATUS downloadStatus
			SHOW_PROGRESS
			EXPECTED_MD5 ${md5sum}
		)
		LIST(GET downloadStatus 0 downloadError)
	endif ()
	if (NOT downloadError EQUAL 0)
		message(FATAL_ERROR "Cannot find/download the source file from:" ${url})
	endif ()
		
	
endif ()
'