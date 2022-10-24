#!/bin/bash
MODEL_NAME=$1 # this is the name of the corpus or subset of the corpus to made into vectors
BASE_DIR=data/output # default output directory
DATA_RAW_DIR=data/raw # default raw data directory
S2V_MODELS_OUTPUT=data/output/models # default output directory for exported s2v models

echo "Building vectors..."

echo "Step 0: Preprocessing raw text..."
STEP0_OUTPUT=data/preprocessed
mkdir $STEP0_OUTPUT
echo "Created directory with path $STEP0_OUTPUT"
python scripts/00_preprocess.py $DATA_RAW_DIR/*.txt $STEP0_OUTPUT

echo "Step 1: scripts/01_parse.py"
STEP1_OUTPUT=$BASE_DIR/01_output
mkdir $STEP1_OUTPUT
echo "Created directory with path $STEP1_OUTPUT"
python scripts/01_parse.py $STEP0_OUTPUT/*.txt $STEP1_OUTPUT

echo "Step 2: Creating s2v..."
STEP2_OUTPUT=$BASE_DIR/02_output
mkdir $STEP2_OUTPUT
python scripts/02_preprocess.py $STEP1_OUTPUT/*.spacy $STEP2_OUTPUT

echo "Step 3: GloVe Build Counts..."
STEP3_OUTPUT=$BASE_DIR/03_output/$MODEL_NAME
mkdir $STEP3_OUTPUT
python scripts/03_glove_build_counts.py GloVe/build $STEP2_OUTPUT $STEP3_OUTPUT 
mv $STEP3_OUTPUT/cooccurrence.shuf.bin $STEP3_OUTPUT/$MODEL_NAME-cooccurrence.shuf.bin
mv $STEP3_OUTPUT/cooccurrence.bin $STEP3_OUTPUT/$MODEL_NAME-cooccurrence.bin
mv $STEP3_OUTPUT/vocab.txt $STEP3_OUTPUT/$MODEL_NAME-vocab.txt

echo "Step 4: Creating GloVe Vectors..."
STEP4_OUTPUT=$BASE_DIR/04_output
mkdir $STEP4_OUTPUT
python scripts/04_glove_train_vectors.py GloVe/build $STEP3_OUTPUT/*.shuf.bin $STEP3_OUTPUT/*vocab.txt $STEP4_OUTPUT --vector-size 300
echo "* Vectors located in $STEP4_OUTPUT"
mv $STEP4_OUTPUT/vectors*.txt $STEP4_OUTPUT/$MODEL_NAME-vectors.txt

echo "Step 5: Exporting to s2v vectors..."
step5_vectors=$STEP4_OUTPUT/$MODEL_NAME-vectors.txt
step5_vocab=$STEP3_OUTPUT/*vocab.txt
step5_final=$S2V_MODELS_OUTPUT/$MODEL_NAME
python scripts/05_export.py $step5_vectors $step5_vocab "$step5_final"
