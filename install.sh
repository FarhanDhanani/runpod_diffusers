#!/bin/bash

# Navigate to the workspace directory
cd /workspace/ || { echo "Failed to cd into workspace"; exit 1; }

# Create a new directory for training
mkdir -p training
cd training/ || { echo "Failed to cd into training directory"; exit 1; }

# Create a Python virtual environment
python -m venv venv || { echo "Failed to create virtual environment"; exit 
1; }

# Modify the venv configuration file to include system site packages
sed -i 's/^include-system-site-packages = false$/include-system-site-packages = true/' venv/pyvenv.cfg || { echo "Failed to modify venv configuration"; exit 1; }


# Activate the virtual environment
source venv/bin/activate || { echo "Failed to activate virtual 
environment"; exit 1; }

# Install required Python packages
pip install torch==2.1.0+cu118 xformers accelerate diffusers transformers comet_ml peft bitsandbytes gdown || { echo "Failed to install Python packages"; exit 1; }
pip install matplotlib tensorflow tensorflow_datasets scipy || { echo "Failed to install additional Python packages"; exit 1; }

# Download files from Google Drive
gdown --folder https://drive.google.com/drive/folders/1xgr3M6QsavXRINKP0F5Mw4lC2sUwplJo || { echo "Failed to download files from Google Drive"; exit 1; }

# Create the model directory structure
mkdir -p model/sandal || { echo "Failed to create model directory structure"; exit 1; }

# Install IPython kernel
python -m ipykernel install --user --name trainingDreamDiffuser || { echo "Failed to install IPython kernel"; exit 1; }

echo "Setup complete!"

