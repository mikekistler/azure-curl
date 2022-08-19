#!/bin/bash

find . -name 'token.json' -depth 1 -mtime -1h | grep . &> /dev/null || az account get-access-token > token.json
