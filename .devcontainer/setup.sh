#!/bin/bash

# register kernel for jupyter notebooks
python -m ipykernel install --user --name devcontainer --display-name "Python (Dev Container)"

pip install black