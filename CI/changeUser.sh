#!/bin/bash
useradd smartslab
export DISPLAY=localhost:0 # Set environment variable for creating plots in python
sudo -u smartslab -H sh -c "python /OpenIPSL/CI/runTests.py"
