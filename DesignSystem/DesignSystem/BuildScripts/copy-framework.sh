#!/bin/sh

#  copy-framework.sh
#  Services
#
#  Created by Marcio Garcia on 06/06/20.
#  Copyright © 2020 Oxl Tech. All rights reserved.

counter=0

echo ${SCRIPT_INPUT_FILE_COUNT}
while (( $counter < ${SCRIPT_INPUT_FILE_COUNT} ))
do
    imputFile="SCRIPT_INPUT_FILE_$counter"
    outputFile="SCRIPT_OUTPUT_FILE_$counter"
    echo ${!imputFile}
    echo ${!outputFile}
    cp -rf ${!imputFile} ${!outputFile}
    counter=$(( counter+1 ))
done
