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
    )

if [ ! -z $RULE ]; then
    cmd+=(--rule $RULE)
fi

cmd+=(--report $REPORT_DIR/report.xml)
cmd+=($CONTENT)

echo "Running oscap-chroot"
echo "${cmd[@]}"
"${cmd[@]}"
