as yet unclassified
printHeader
	
	self puts: '# This is automatically generated file using ', self configurationName, ' on ',
		Date current asString, ' ' , Time current asString;
		puts: 'cmake_minimum_required(VERSION 2.6.2)'