generating actions
setVariables

	gen
		set: #libName toString: self canonicalName;
		set: #workDir toString: '${thirdpartyDir}/${libName}';
		set: #unpackedDirName toString: self unpackedDirName;
		set: #libSourcesDir toString: '${workDir}/${unpackedDirName}';
		set: #url toString: self downloadURL;
		set: #md5sum toString: self archiveMD5Sum;
		set: #archiveFileName toString: self archiveFileName;
		set: #installPrefix toString: '${thirdpartyDir}/out'.