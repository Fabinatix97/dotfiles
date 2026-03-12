#!/bin/sh

top -bn1 | grep '%Cpu' | awk '{printf "%.1f%%", 100 - $8}'
