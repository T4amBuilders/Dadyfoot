#!/bin/bash
echo "Starting script..."
echo "Go to frontend..."
cd ./frontend/
echo "-------------------"
echo "Verifiying code style..."
flutter analyze
echo "Code style verified..."
echo "-------------------"
echo "Script completed!"
