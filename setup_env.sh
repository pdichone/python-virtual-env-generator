#!/bin/bash

# Define the environment name
ENV_NAME="myvenv"

# Function to create and activate virtual environment for Unix-like systems
create_activate_unix() {
    python3 -m venv $ENV_NAME
    source "$ENV_NAME/bin/activate"
}

# Function to create and activate virtual environment for Windows
create_activate_windows() {
    py -m venv $ENV_NAME
    source "$ENV_NAME/Scripts/activate"
}

# Detect the operating system and create/activate virtual environment
case "$(uname -s)" in
    Linux*|Darwin*)
        create_activate_unix
        ;;
    MINGW*|CYGWIN*|MSYS*)
        create_activate_windows
        ;;
    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac

# create an app.py file if it doesn't exist
if [ ! -f "app.py" ]; then
    touch app.py
    echo "from flask import Flask" >> app.py
    echo "app = Flask(__name__)" >> app.py
    echo "" >> app.py
    echo "@app.route('/')" >> app.py
    echo "def hello():" >> app.py
    echo "    return 'Hello World!'" >> app.py
    echo "" >> app.py
    echo "if __name__ == '__main__':" >> app.py
    echo "    app.run()" >> app.py
fi

# Check if requirements.txt exists, if not, create it and add essential packages
if [ ! -f "requirements.txt" ]; then
    echo "flask" >> requirements.txt
    echo "python-dotenv" >> requirements.txt
    echo "requests" >> requirements.txt
fi

# Install dependencies from requirements.txt
pip install -r requirements.txt

echo "🚀✨Environment setup complete.✨🚀"
echo "🎗️ Run 'source $ENV_NAME/bin/activate' (Unix-like) or 'source $ENV_NAME/Scripts/activate' (Windows) to activate the virtual environment."
