#!/usr/bin/env bash
# 上列為宣告執行 script 程式用的殼程式(shell)的 shebang
# extract-translatable-strings.bash - Extract translatable strings for translation
# 林博仁(Buo-Ren, Lin) <Buo.Ren.Lin@gmail.com> © 2016

######## File scope variable definitions ########
# Defensive Bash Programming - not-overridable primitive definitions
# http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/
declare -r PROGRAM_FILENAME="$(basename "$0")"
declare -r PROGRAM_DIRECTORY="$(realpath --no-symlinks "$(dirname "$0")")"
declare -r PROGRAM_ARGUMENT_ORIGINAL_LIST="$@"
declare -r PROGRAM_ARGUMENT_ORIGINAL_NUMBER=$#

# Project directory structures
declare -r PROJECT_ROOT_DIRECTORY="$(realpath --no-symlinks "$PROGRAM_DIRECTORY/..")"
source "$PROJECT_ROOT_DIRECTORY/Project Settings.source.bash"

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

######## Included files ended ########

######## Program ########
# Defensive Bash Programming - main function, program entry point
# http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/
main() {
	
	# GNU Gettext - Prepraring Strings
	# Old command that I think it should work...but not.
	#xgettext --default-domain="$SOFTWARE_NAME" --output-dir="$PROJECT_TRANSLATIONS_ROOT_DIRECTORY" --from-code=UTF-8 --keyword=_ --copyright-holder="林博仁(Buo-Ren, Lin) <Buo.Ren.Lin@gmail.com>" --foreign-user --package-name="$SOFTWARE_NAME" --package-version="dev-trunk" --msgid-bugs-address=https://github.com/Lin-Buo-Ren/Hello_GNU_Gettext_World_/issues --no-wrap --directory="$PROJECT_SOURCE_CODE_ROOT_DIRECTORY"
	find "$PROJECT_SOURCE_CODE_ROOT_DIRECTORY" -name "*.c" -exec xgettext --default-domain="$SOFTWARE_NAME" --output-dir="$PROJECT_TRANSLATIONS_ROOT_DIRECTORY" --from-code=UTF-8 --keyword=_ --copyright-holder="林博仁(Buo-Ren, Lin) <Buo.Ren.Lin@gmail.com>" --package-name="$SOFTWARE_NAME" --package-version="dev-trunk" --msgid-bugs-address=https://github.com/Lin-Buo-Ren/Hello_GNU_Gettext_World_/issues --no-wrap --directory="$PROJECT_ROOT_DIRECTORY" {} \;
	
	# Workaround: strip the current working directory path from string source location for privacy reasons
	# TODO: find a way to properly escape regexp pattern, this only handles front slash
	strip_path_pattern="$(printf "$PROJECT_ROOT_DIRECTORY" | sed 's/\//\\\//g')\/"
	sed --in-place "s/^#: $strip_path_pattern/#: /g" "$PROJECT_TRANSLATIONS_ROOT_DIRECTORY/$SOFTWARE_NAME.po"
	
	mv "$PROJECT_TRANSLATIONS_ROOT_DIRECTORY/$SOFTWARE_NAME.po" "$PROJECT_TRANSLATIONS_ROOT_DIRECTORY/$SOFTWARE_NAME.pot"
	
	## 正常結束 script 程式
	exit 0
}
main
######## Program ended ########
