#!/bin/bash

virtualenv --python=python2.7 .env
source .env/bin/activate
pip install -r requirements.txt