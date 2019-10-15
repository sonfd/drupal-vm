#!/bin/bash

# Add /var/bin to $PATH
if [[ ":$PATH:" == *":$var/bin:"* ]]; then
  export PATH=$PATH:/var/bin
fi
