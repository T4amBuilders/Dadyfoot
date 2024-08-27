#!/bin/bash
echo "Starting script..."
echo "Go to frontend..."
cd ../frontend/
echo "-------------------"
echo "Verifiying code style..."
flutter analyze
echo "Code style verified..."
echo "-------------------"
echo "Verifiying quality code..."
flutter pub run dart_code_metrics:metrics lib
echo "Quality code verified..."
echo "-------------------"
echo "Script completed!"
