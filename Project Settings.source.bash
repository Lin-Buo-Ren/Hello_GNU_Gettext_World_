# Project Settings, declare the correct $PROJECT_ROOT_DIRECTORY then source this script
## Software(project) Name
declare -r SOFTWARE_NAME="Hello GNU Gettext World!"
#declare -r SOFTWARE_NAME_DEPRECATED="Hello_GNU_Gettext_World_"
#define -r SOFTWARE_IDENTIFIER "tw.idv.Vdragon.projects.hello-gnu-gettext-world-"

## Project directories definitions
declare -r PROJECT_SOURCE_CODE_ROOT_DIRECTORY="$(realpath --no-symlinks "$PROJECT_ROOT_DIRECTORY/Source Code")"
declare -r PROJECT_TRANSLATIONS_ROOT_DIRECTORY="$(realpath --no-symlinks "$PROJECT_ROOT_DIRECTORY/Translations")"
declare -r PROJECT_SOFTWARE_RELEASE_TREE_TEMPLATE_ROOT_DIRECTORY="$(realpath --no-symlinks "$PROJECT_ROOT_DIRECTORY/Software Release Tree Template")"
declare -r PROJECT_THIRD_PARTY_SOFTWARE_ROOT_DIRECTORY="$(realpath --no-symlinks "$PROJECT_ROOT_DIRECTORY/Third-party Software")"

## Release settings
declare -r SOFTWARE_PATH_CONVERSION_FROM_EXECUTABLE_DIRECTORY_TO_RELEASE_ROOT_DIRECTORY=..

declare -pF 2>/dev/null | grep --extended-regexp "^declare.* RELEASE_ROOT_DIRECTORY$" &>/dev/null
if [ $? -eq 0 ]; then
	declare -r RELEASE_EXECUTABLES_ROOT_DIRECTORY="$(realpath --no-symlinks "$RELEASE_ROOT_DIRECTORY/Executables")"
	declare -r RELEASE_TRANSLATIONS_ROOT_DIRECTORY="$(realpath --no-symlinks "$RELEASE_ROOT_DIRECTORY/Translations")"
fi
