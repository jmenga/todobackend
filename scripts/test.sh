#!/bin/bash
# Activate virtual environment
. /appenv/bin/activate

# Install application test requirements
pip install -r requirements_test.txt

# Run test.sh arguments
exec $@