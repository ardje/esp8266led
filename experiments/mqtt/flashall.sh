#!/bin/bash
for id in a0:20:a6:04:{05:1f,03:76,02:d2,02:e6}; do
	../mqtt/flashit.lua $id "$@"
done
