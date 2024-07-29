#!/bin/bash

# Navigate to the runpod-volume directory
cd runpod-volume || { echo "Failed to cd into workspace"; exit 1; }

# Create a new directory for inference
mkdir -p inference
cd inference || { echo "Failed to cd into inference"; exit 1; }

# Create a Python virtual environment
python -m venv env || { echo "Failed to create virtual environment"; exit 1; }
sed -i 's/^include-system-site-packages = false$/include-system-site-packages = true/' venv/pyvenv.cfg

# Activate the virtual environment
source venv/bin/activate || { echo "Failed to activate virtual environment"; exit 1; }

# Install required Python packages
pip install -r requirements.txt


export LORA_WEIGHT_PATH = '../training/lora_weight.pkt'
export PRETAINED_MODEL_PATH = '../training/stable-diffusion-v1.5.pkt'

echo "Setup complete"