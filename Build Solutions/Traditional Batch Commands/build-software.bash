#!/usr/bin/env bash
# build-software.bash - program to build the software
# 林博仁(Buo-Ren, Lin) <Buo.Ren.Lin@gmail.com> © 2016

######## File scope variable definitions ########
# Defensive Bash Programming - not-overridable primitive definitions
# http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/
declare -r PROGRAM_FILENAME="$(basename "$0")"
declare -r PROGRAM_DIRECTORY="$(realpath --no-symlinks "$(dirname "$0")")"
declare -r PROGRAM_ARGUMENT_ORIGINAL_LIST="$@"
declare -r PROGRAM_ARGUMENT_ORIGINAL_NUMBER=$#

# Project directory structures
declare -r PROJECT_ROOT_DIRECTORY="$(realpath --no-symlinks "$PROGRAM_DIRECTORY/../..")"
source "$PROJECT_ROOT_DIRECTORY/Project Settings.source.bash"

# Build solution directory definitions
declare -r BUILD_SOLUTION_ROOT_DIRECTORY="$PROGRAM_DIRECTORY"
declare -r BUILD_SOLUTION_DIRECTORY_INTERMEDIATE_BUILD_ARTIFACTS="$BUILD_SOLUTION_ROOT_DIRECTORY/Intermediate Build Artifacts"
declare -r BUILD_SOLUTION_DIRECTORY_RELEASED_PRODUCT="$BUILD_SOLUTION_ROOT_DIRECTORY/Released Product"
declare -r BUILD_SOLUTION_DIRECTORY_TEMPORARY_RELEASE_ROOT_DIRECTORY="$BUILD_SOLUTION_DIRECTORY_INTERMEDIATE_BUILD_ARTIFACTS/$SOFTWARE_NAME"

## Unofficial Bash Script Mode
## http://redsymbol.net/articles/unofficial-bash-strict-mode/
# 將未定義的變數的參考視為錯誤
set -u

# Exit immediately if a pipeline, which may consist of a single simple command, a list, or a compound command returns a non-zero status.  The shell does not exit if the command that fails is part of the command list immediately following a `while' or `until' keyword, part of the test in an `if' statement, part of any command executed in a `&&' or `||' list except the command following the final `&&' or `||', any command in a pipeline but the last, or if the command's return status is being inverted with `!'.  If a compound command other than a subshell returns a non-zero status because a command failed while `-e' was being ignored, the shell does not exit.  A trap on `ERR', if set, is executed before the shell exits.
set -e

# If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail

######## File scope variable definitions ended ########

######## Included files ########
source "$PROGRAM_DIRECTORY/build-c-version.function.bash"

######## Included files ended ########

######## Program ########
# Defensive Bash Programming - main function, program entry point
# http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/
main() {
	( cd "$PROJECT_THIRD_PARTY_SOFTWARE_ROOT_DIRECTORY"/BinReloc && ./generate.pl normal )
	"$PROJECT_TRANSLATIONS_ROOT_DIRECTORY"/convert-portable-object-to-machine-object.bash
	
	build_c_version
	cp --recursive --no-target-directory "$PROJECT_SOFTWARE_RELEASE_TREE_TEMPLATE_ROOT_DIRECTORY"/SOFTWARE_NAME "$BUILD_SOLUTION_DIRECTORY_TEMPORARY_RELEASE_ROOT_DIRECTORY"
	cp "$BUILD_SOLUTION_DIRECTORY_INTERMEDIATE_BUILD_ARTIFACTS/hello-gnu-gettext-world-c" "$BUILD_SOLUTION_DIRECTORY_TEMPORARY_RELEASE_ROOT_DIRECTORY/Executables"
	cp --recursive "$PROJECT_TRANSLATIONS_ROOT_DIRECTORY"/zh_TW "$PROJECT_TRANSLATIONS_ROOT_DIRECTORY"/convert-portable-object-to-machine-object.bash "$BUILD_SOLUTION_DIRECTORY_TEMPORARY_RELEASE_ROOT_DIRECTORY/Translations"
	
	tar --verbose --create --bzip2 --directory "$BUILD_SOLUTION_DIRECTORY_INTERMEDIATE_BUILD_ARTIFACTS" --file "$BUILD_SOLUTION_DIRECTORY_RELEASED_PRODUCT/$SOFTWARE_NAME.tar.bz2" "$(basename "$BUILD_SOLUTION_DIRECTORY_TEMPORARY_RELEASE_ROOT_DIRECTORY")"
	
	## 正常結束 script 程式
	exit 0
}
main
######## Program ended ########
