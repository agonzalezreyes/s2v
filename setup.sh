#!/bin/bash

echo "General dependencies..."

pip install -r requirements.txt
pip install -r scripts/requirements.txt
python -m spacy download en_core_web_sm

echo "Handling GloVe..."

git submodule update --init --recursive
cd GloVe && make
cd .. 

echo "Creating data subfolders..."
mkdir data/output
mkdir data/preprocessed
mkdir data/raw

echo "Setup done!"