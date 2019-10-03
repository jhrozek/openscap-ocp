#!/bin/bash

if [ -z $HOSTROOT ]; then
    echo "hostroot not set"
    exit 1
fi

if [ -z $PROFILE ]; then
    echo "profile not set"
    exit 1
fi

if [ -z $CONTENT ]; then
    echo "content not set"
    exit 1
fi

if [ -z $REPORT_DIR ]; then
    echo "report_dit not set"
    exit 1
fi

cmd=(
    oscap-chroot $HOSTROOT xccdf eval \
    --fetch-remote-resources \
    --profile $PROFILE
    --report /tmp/report.xml
    )

if [ ! -z $RULE ]; then
    cmd+=(--rule $RULE)
fi

cmd+=($CONTENT)

# The whole purpose of the shell entrypoint is to semi-atomically
# move the results file when the command is done so the log collector
# picks up the whole thing and not a partial file
echo "Running oscap-chroot as ${cmd[@]}"
"${cmd[@]}"
test -f /tmp/report.xml && mv /tmp/report.xml $REPORT_DIR
