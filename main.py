"""
Hermes Agent - Botkeep deployment entry point.
Runs the Hermes messaging gateway in the foreground.
"""

import os
import sys

# Add the repo root to the path so we can import hermes packages
REPO_ROOT = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, REPO_ROOT)
os.chdir(REPO_ROOT)

# Set HERMES_HOME to a writable location for Botkeep's runtime
os.environ.setdefault("HERMES_HOME", os.path.join(REPO_ROOT, ".hermes-data"))
os.makedirs(os.environ["HERMES_HOME"], exist_ok=True)

# Import and run the gateway
from hermes_cli.main import main

if __name__ == "__main__":
    # Simulate: hermes gateway run
    sys.argv = ["hermes", "gateway", "run"] + sys.argv[1:]
    sys.exit(main())
