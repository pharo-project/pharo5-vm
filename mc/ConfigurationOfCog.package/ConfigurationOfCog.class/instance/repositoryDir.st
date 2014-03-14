accessing
repositoryDir 
	^ repositoryDir ifNil: [ '../mc' asFileReference ].