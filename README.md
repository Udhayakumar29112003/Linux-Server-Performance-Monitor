# Linux-Server-Performance-Monitor
# 🖥️ Server Performance Monitor (with Report Saving)

A **modular Bash script** that monitors server performance and **saves the output to a timestamped report file**.

## ✅ Features
- **Monitors**:
  - CPU Load
  - Memory Usage
  - Disk Usage
  - Top 5 processes (CPU & Memory)
- **Stores output in a report file** (`Report_YYYY-MM-DD_HH-MM-SS.txt`).
- **Displays output in terminal**.
- **Handles missing commands & errors gracefully**.

## 🚀 How to Use

1. Clone the repository:
   ```bash
  git clone https://github.com/yourusername/server-monitor.git
  cd server-monitor
  chmod +x server-monitor.sh
  ./server-monitor.sh
