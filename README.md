# Lightweight repository to create sense2vec embeddings

### Setup & Example

0. Clone this repository:

        $ git clone https://github.com/agonzalezreyes/s2v.git

1. Create a conda environemt and activate it:

        $ conda create -n [NAME] python=3.9.7 pip
        $ conda activate [NAME]

    [NAME] = Name for your environment, e.g. `conda create -n env python=3.9.7 pip` and `conda activate env`

2. Run the setup bash script to install all dependencies and submodules:

        (env) $ sh setup.sh
    
3.  Given a raw text file in `data/raw`, build vectors example:

        (env) $ sh build_vectors.sh [MODEL-NAME]

    [MODEL-NAME] = The name you want to give to the output vector files, e.g. `sh build_vectors.sh aristotle`.

### References:

[1] Some scripts are based or taken from [sense2vec](https://github.com/explosion/sense2vec).
