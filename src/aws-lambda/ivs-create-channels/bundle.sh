#!/bin/bash
set -e

pip () {
    command pip3 "$@"
}

LAMBDA_SOURCE=ivs-create-channels.py
PACKAGE_FILE=ivs-create-channels.zip

echo "Cleaning up intermediate files"
[ -e ${PACKAGE_FILE} ] && rm ${PACKAGE_FILE}
[ -e "package" ] && rm -rf package

echo "Installing Lambda dependencies"
pip install -r requirements.txt --target ./package

echo "Building Lambda deployment package"
cd package
zip a -r -mx9 ${OLDPWD}/${PACKAGE_FILE} .
cd ${OLDPWD}

echo "Adding Lambda function source code to package"
zip u ${PACKAGE_FILE} ${LAMBDA_SOURCE}


echo "Done!"