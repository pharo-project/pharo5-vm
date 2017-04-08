param (
    [switch]$All,
    [switch]$BuildSources,
    [switch]$BuildVm,
    [switch]$PackVm
)

. $PSScriptRoot\config.ps1

function Run-Bash($Command) {
    Invoke-Expression "bash -c ""$Command"""
}



if ($All) {
    $BuildSources = $BuildVm = $PackVm = $true
}

if ($BuildSources) {
    Run-Bash -Command "cd scripts; ./build-sources.sh -a $SRC_ARCH"
}

if ($BuildVm) {
    Run-Bash -Command "scripts/windows/build_vm.sh"
}

if ($PackVm) {
    Run-Bash -Command "cd scripts; export ARCH=$ARCH; export SRC_ARCH=$SRC_ARCH; ./pack-vm.sh"
}
