Taken from: http://sumgroup.wikispaces.com/iPhone_Dynamic_Library 

How to enable XCode to build Dynamic Libraries for the iPhone

When XCode is installed it doesn't have the ability to create dynamic libraries using the iPhone SDK. If you create a new Mac OS X Cocoa Dynamic Library project and then in project settings change the base SDK to Device - iPhone OS 2.2, when you build you will see the error:

target specifies product type 'com.apple.product-type.library.dynamic', but there's no such product type for the 'iphoneos' platform

To fix this, add the below block of text to /Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Specifications/iPhoneOSProductTypes.xcspec

Or for Xcode installed from Mac App Store the file is:
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Specifications/iPhoneOSProductTypes.xcspec

(Note: this is just taken from the Mac OS X SDK here /Developer/Platforms/MacOSX.platform/Developer/Library/Xcode/Specifications/)
    // Dynamic library
    {   Type = ProductType;
        Identifier = com.apple.product-type.library.dynamic;
        Class = PBXDynamicLibraryProductType;
        Name = "Dynamic Library";
        Description = "Dynamic library";
        IconNamePrefix = "TargetPlugin";
        DefaultTargetName = "Dynamic Library";
        DefaultBuildProperties = {
            FULL_PRODUCT_NAME = "$(EXECUTABLE_NAME)";
            MACH_O_TYPE = "mh_dylib";
            REZ_EXECUTABLE = YES;
            EXECUTABLE_SUFFIX = ".$(EXECUTABLE_EXTENSION)";
            EXECUTABLE_EXTENSION = "dylib";
            PUBLIC_HEADERS_FOLDER_PATH = "/usr/local/include";
            PRIVATE_HEADERS_FOLDER_PATH = "/usr/local/include";
            INSTALL_PATH = "/usr/local/lib";
            DYLIB_INSTALL_NAME_BASE = "$(INSTALL_PATH)";
            LD_DYLIB_INSTALL_NAME = "$(DYLIB_INSTALL_NAME_BASE:standardizepath)/$(EXECUTABLE_PATH)";
            DYLIB_COMPATIBILITY_VERSION = "1";
            DYLIB_CURRENT_VERSION = "1";
            FRAMEWORK_FLAG_PREFIX = "-framework";
            LIBRARY_FLAG_PREFIX = "-l";
            LIBRARY_FLAG_NOSPACE = YES;
            STRIP_STYLE = "debugging";
            GCC_INLINES_ARE_PRIVATE_EXTERN = YES;
            CODE_SIGNING_ALLOWED = YES;
        };
        PackageTypes = (
            com.apple.package-type.mach-o-dylib   // default
        );
    },

Also add the below code block to /Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Specifications/iPhoneOSPackageTypes.xcspec

or for Xcode installed from Mac App Store the file is:
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Specifications/iPhoneOSPackageTypes.xcspec

    // Mach-O dynamic library
    {   Type = PackageType;
        Identifier = com.apple.package-type.mach-o-dylib;
        Name = "Mach-O Dynamic Library";
        Description = "Mach-O dynamic library";
        DefaultBuildSettings = {
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_PATH = "$(EXECUTABLE_NAME)";
        };
        ProductReference = {
            FileType = compiled.mach-o.dylib;
            Name = "$(EXECUTABLE_NAME)";
            IsLaunchable = NO;
        };
    },
Look at the other stuff in the files to see where to paste it. Make sure the array of entries is still valid and you haven’t pasted outside a bracket.

You will need to do this every time you install a newer version of the iPhone SDK. The chunks above are valid for the 2.2 SDK and are copied from the Mac OS X Platform versions of these xcspec files.
