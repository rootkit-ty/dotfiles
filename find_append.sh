#!/bin/bash
find $1 | sed -e "s/^\.\//!/g" | sed -e "s/^\./!\./g" >> .gitignore