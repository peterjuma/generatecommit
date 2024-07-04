#!/bin/bash

COMMITMSG=$(python3 commitmsg.py)
git commit --amend -m "${COMMITMSG}"
git push --force

