baselines
squeak45baseline
	"The base Squeak-4.5-13680 package set."
	^#(	name 'base-Squeak45-eem'
		repository ('http://source.squeak.org/squeak45')
		dependency ('Squeak-Version' 'Squeak-Version-ar.4662' '6bfece28-65a4-b147-9462-417b2e86acd0')
		dependency ('311Deprecated' '311Deprecated-nice.2' '6df45c33-740a-fc4f-b3d0-45412ad7d284')
		dependency ('39Deprecated' '39Deprecated-ar.19' '8da20c38-7d28-3241-9f29-da261d6f9bfe')
		dependency ('45Deprecated' '45Deprecated-fbs.24' '4033c169-94c6-7741-9aee-5a7570a7ec7a')
		dependency ('Balloon' 'Balloon-nice.24' '97e2ed51-707d-4da1-ab4f-35add3deee5e')
		dependency ('Network' 'Network-nice.150' 'c844e5ea-c919-44fc-905e-69487b035947')
		dependency ('Compression' 'Compression-fbs.40' '82b0d6e4-0239-1241-968c-461a785fb6a7')
		dependency ('Graphics' 'Graphics-nice.289' 'e809bcbf-53e1-420b-846a-9e86e0dd1f06')
		dependency ('Multilingual' 'Multilingual-fbs.194' '07f4a7b5-7169-3345-85fc-5a8ba04e5323')
		dependency ('CollectionsTests' 'CollectionsTests-dtl.214' 'cf157d3a-2d71-46f3-86ce-450ee24e8d27')
		dependency ('PackageInfo-Base' 'PackageInfo-Base-nice.68' 'b6669527-9a35-4783-a64f-8f2af97e330b')
		dependency ('Compiler' 'Compiler-nice.279' '94b1b5f8-f71b-4425-b035-461d3dc94e3f')
		dependency ('Environments' 'Environments-ul.46' 'cfd9e7f7-6a4b-400e-b9c7-9c6239da4752')
		dependency ('Kernel' 'Kernel-dtl.836' '410e695f-7f23-43e4-9dc2-d292b9954f0d')
		dependency ('MonticelloConfigurations' 'MonticelloConfigurations-fbs.123' 'b9735d10-7cf4-a746-8a64-b50fa9cf273f')
		dependency ('Tools' 'Tools-cmm.519' 'dae6bdb9-8b54-491a-a2a4-0b114f02e10d')
		dependency ('MorphicExtras' 'MorphicExtras-tpr.147' 'e76a71a5-6be9-4420-b71a-2c92d900c476')
		dependency ('Files' 'Files-dtl.130' '8ee82071-69f7-446d-8ed7-77eafc838f03')
		dependency ('System' 'System-dtl.666' '098b856a-ecc5-498a-bceb-ef3457d3511e')
		dependency ('Collections' 'Collections-ul.564' '4b9a37ef-df86-40a0-a0dd-8e8b2c04d4ed')
		dependency ('Monticello' 'Monticello-cmm.586' 'a4dbd656-e50a-47ba-8661-44f8c87bb3e0')
		dependency ('EToys' 'EToys-cmm.117' 'c3e71dbe-17af-4b71-ad9c-c0bb2a2bc193')
		dependency ('Exceptions' 'Exceptions-cmm.49' '6cede9fe-b13d-481a-b8de-bb004ece1145')
		dependency ('FlexibleVocabularies' 'FlexibleVocabularies-bf.13' '55c72a72-619e-4a81-831f-303600bbd792')
		dependency ('GraphicsTests' 'GraphicsTests-fbs.38' '081189cc-a44f-fa4e-965e-25438280ea93')
		dependency ('Installer-Core' 'Installer-Core-cmm.392' '7cb5c040-6f68-479d-bc9e-0b264b172443')
		dependency ('KernelTests' 'KernelTests-nice.259' '0f7301b0-612c-49d8-936f-775995b35e0f')
		dependency ('GetText' 'GetText-nice.34' '4d432f8e-55be-428a-9138-63dd1738035e')
		dependency ('Sound' 'Sound-nice.38' 'b626daf0-be23-4fb8-b2d5-04b9cd370539')
		dependency ('ToolBuilder-Tests' 'ToolBuilder-Tests-cmm.1' 'e77685b9-ca09-40c0-b84e-6caee75f4075')
		dependency ('Morphic' 'Morphic-cmm.720' 'e5e81c18-990b-4e35-b325-adb032b8418d')
		dependency ('MorphicTests' 'MorphicTests-nice.24' 'e33a9ad3-2f39-4c19-a3a7-dc87f18177fc')
		dependency ('MorphicExtrasTests' 'MorphicExtrasTests-fbs.3' '1c039763-bc92-834c-943e-d96d8820cbd7')
		dependency ('MultilingualTests' 'MultilingualTests-fbs.18' '07e26018-8455-3349-9b44-9ecb4aaeefb2')
		dependency ('Nebraska' 'Nebraska-nice.36' 'cc80dca4-ed72-4c39-952c-3b37886100de')
		dependency ('NetworkTests' 'NetworkTests-fbs.37' '97699685-5826-fe47-af98-356971abf2fb')
		dependency ('PreferenceBrowser' 'PreferenceBrowser-fbs.49' '72d30dfa-0ff5-4347-9823-eb77ae236f8f')
		dependency ('Protocols' 'Protocols-nice.46' '15b63671-d541-4c1d-9ff5-72da4fc5bfe9')
		dependency ('SMBase' 'SMBase-nice.132' 'a70c8bd2-3eee-4e21-b9c6-113f6b194527')
		dependency ('SMLoader' 'SMLoader-fbs.79' '9f7d983e-d958-4115-94aa-21302f89ad8b')
		dependency ('ST80' 'ST80-cmm.172' '47b2f84a-6951-480b-88f2-b2726dba08bd')
		dependency ('ST80Tests' 'ST80Tests-nice.2' '7ee5426b-73f1-48ac-8ec4-3943dc452cb6')
		dependency ('ST80Tools' 'ST80Tools-fbs.1' '108ec7bc-d1f5-dd4b-9511-e7a653a71e9f')
		dependency ('SUnit' 'SUnit-fbs.99' 'a5be81dd-6e9f-8d41-a091-3c6c27a28abe')
		dependency ('SUnitGUI' 'SUnitGUI-fbs.59' '0bfcf308-0d02-a749-9930-6229492cca48')
		dependency ('ScriptLoader' 'ScriptLoader-cmm.338' 'adb79117-0915-40a5-a5ee-c766e4b50d42')
		dependency ('Services-Base' 'Services-Base-topa.51' '94328e86-1643-4090-8f18-bc4467119161')
		dependency ('SmallLand-ColorTheme' 'SmallLand-ColorTheme-fbs.6' 'a78b81e3-3b11-c24e-9c84-3bb5319e0858')
		dependency ('SystemChangeNotification-Tests' 'SystemChangeNotification-Tests-nice.23' '3eed6d26-4aef-4095-a604-d9f914240281')
		dependency ('Tests' 'Tests-cmm.290' 'f3fccfae-6baf-4093-ba62-e15ef110a687')
		dependency ('ToolBuilder-Kernel' 'ToolBuilder-Kernel-nice.60' '86949a07-725b-4a27-a7cd-a827c74f48be')
		dependency ('ToolBuilder-MVC' 'ToolBuilder-MVC-fbs.34' 'aded987d-5cd5-6f41-9635-1d38da947ddf')
		dependency ('ToolBuilder-Morphic' 'ToolBuilder-Morphic-fbs.91' 'abaa076b-af43-af42-8c98-7a71482c6a30')
		dependency ('ToolBuilder-SUnit' 'ToolBuilder-SUnit-fbs.19' '3e30756c-2af8-0741-836f-0d42a9d5af32')
		dependency ('ToolsTests' 'ToolsTests-cmm.68' '98c1608a-6cb3-4a03-a28a-dd101e6c876b')
		dependency ('MonticelloForTraits' 'MonticelloForTraits-fbs.1' '160be615-5ab7-4148-a7cb-60dd629ab085')
		dependency ('Traits' 'Traits-topa.302' '58712f55-3f3f-467e-ac0e-e118c9737c53')
		dependency ('TraitsTests' 'TraitsTests-fbs.13' '0429146f-6767-4a4f-8fce-37571625920a')
		dependency ('TrueType' 'TrueType-nice.28' '42a74f04-e193-455b-a2c1-14ec51724234')
		dependency ('Universes' 'Universes-nice.46' '805eb73f-391b-4e3f-aef9-64add79e4e8c')
		dependency ('VersionNumber' 'VersionNumber-cmm.4' '68fb1f05-d3e2-4c9b-9234-20a9bed166dc')
		dependency ('XML-Parser' 'XML-Parser-fbs.36' 'a2d9791a-c341-564b-9b57-a0fe9f42b66f')
		dependency ('ReleaseBuilder' 'ReleaseBuilder-cmm.114' 'ea773780-69e1-48dd-a16c-e167acb9de04')
		dependency ('ShoutCore' 'ShoutCore-cwp.40' '81b3e230-2e8a-42c5-9521-e54338fadb6f')
		dependency ('VersionNumberTests' 'VersionNumberTests-fbs.4' '953a944c-9648-dd4b-898e-9e10e0507b91')
		dependency ('HelpSystem-Core' 'HelpSystem-Core-ul.56' '6d8a0d54-5f60-da45-8c3c-d42ea8abd999')
		dependency ('HelpSystem-Tests' 'HelpSystem-Tests-fbs.15' '8927a848-29a0-f54c-8c79-efb8070c4702')
		dependency ('Help-Squeak-Project' 'Help-Squeak-Project-kfr.10' 'b86eb622-cc53-634d-aa65-aed2c86263f9')
		dependency ('Help-Squeak-TerseGuide' 'Help-Squeak-TerseGuide-dtl.2' '8b18cab9-7183-4c5e-8cac-f79c4400da43')
		dependency ('SystemReporter' 'SystemReporter-ul.21' '34c5c48c-e7cc-4dfe-8133-6dec3bc63ff7')
		dependency ('BalloonTests' 'BalloonTests-egp.2' 'a8206c39-12ee-4222-a29a-caa537e037c4')
		dependency ('CommandLine' 'CommandLine-fbs.2' '414e59b8-4f4a-814d-9dac-b7b9886e92a0')
		dependency ('UpdateStream' 'UpdateStream-nice.4' '5fcdedce-88aa-469a-bf8b-32820f051c4f')
		)