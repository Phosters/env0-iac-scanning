#!/bin/bash

# Run Checkov against the specified directory
checkov -d . --quiet --output json > checkov_report.json

# Exit with an error code if Checkov finds any issues
if [ $? -ne 0 ]; then
    echo "Checkov scan failed. Please review the report."
    exit 1
fi


