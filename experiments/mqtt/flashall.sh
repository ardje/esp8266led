#!/bin/bash
for id in a0:20:a6:04:{05:1f,03:b7,03:76,01:c8,02:d2,02:e6}; do
	./flashit.lua $id "$@"
done
