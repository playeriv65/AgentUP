from pathlib import Path
import os

BASE_DIR = Path(__file__).parent.resolve()
os.environ.setdefault("SAU_BILIUP_RUNTIME_ROOT", str(BASE_DIR / ".runtime" / "biliup"))
XHS_SERVER = "http://127.0.0.1:11901"
LOCAL_CHROME_PATH = os.environ.get("AGENTUP_CHROME_PATH", "C:/Program Files/Google/Chrome/Application/chrome.exe")
LOCAL_CHROME_HEADLESS = True
DEBUG_MODE = True
YT_PROXY = os.environ.get("AGENTUP_YT_PROXY") or None
