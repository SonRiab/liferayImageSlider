#!/usr/bin/env bash
# #
# # (c) 2016-present [j]karef GmbH. All rights reserved.
# #
# # @author Matthias Muenzner <matthias.muenzner@jkaref.com>
# #

BASENAME=$0
BASEDIR=$1
PATTERN=$2
PARAMS=${@:3}

# #
# #
# #
function translate_language_properties()
{
    echo -n "- running translate_language_properties"

    NATIVE2ASCII_BIN=`which native2ascii`
    NATIVE2ASCII_OPT="-reverse"

    SED_BIN=`which sed`

    if [[ -z ${PATTERN} ]]; then
        PATTERN="-esc"
    fi

    REPLACE=""
    LANGUAGES_SED_OPT="-e s/${PATTERN}/${REPLACE}/"

    LANGUAGE_FILES="Language-esc.properties Language-esc_de_DE.properties"
    LANGUAGES_PATH="${BASEDIR}/src/main/resources/languages"

    for INPUT in ${LANGUAGE_FILES}; do
        OUTPUT=`echo ${INPUT} | ${SED_BIN} ${LANGUAGES_SED_OPT}`
        ${NATIVE2ASCII_BIN} ${NATIVE2ASCII_OPT} ${LANGUAGES_PATH}/${INPUT} ${LANGUAGES_PATH}/${OUTPUT}
    done
}

echo "BUILD HELPER 1.0"
echo "----------------"

translate_language_properties