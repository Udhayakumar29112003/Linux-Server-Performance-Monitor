#!/bin/bash

# Create a timestamped report file
report_file="Report_$(date +'%Y-%m-%d_%H-%M-%S').txt"

#check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}


check_cpu_load() {
    echo -e "\n**CPU Load:**" | tee -a "$report_file"
    if command_exists top; then
        top -bn1 | grep "load average" | awk '{print "Load Average: " $10 $11 $12}' | tee -a "$report_file"
    else
        echo "Error: 'top' command not found. Please install it." | tee -a "$report_file"
    fi
}


check_memory_usage() {
    echo -e "\n**Memory Usage:**" | tee -a "$report_file"
    if command_exists free; then
        free -h | tee -a "$report_file"
    else
        echo "Error: 'free' command not found. Please install procps package." | tee -a "$report_file"
    fi
}

check_disk_usage() {
    echo -e "\n**Disk Usage:**" | tee -a "$report_file"
    if command_exists df; then
        df -h | grep "^/dev/" | tee -a "$report_file" || echo "Error: No disk partitions found." | tee -a "$report_file"
    else
        echo "Error: 'df' command not found. Please install coreutils package." | tee -a "$report_file"
    fi
}

# Function to display Top 5 Processes by CPU Usage
check_top_cpu_processes() {
    echo -e "\n**Top 5 Processes by CPU Usage:**" | tee -a "$report_file"
    if command_exists ps; then
        ps -eo pid,comm,%cpu --sort=-%cpu | head -6 | tee -a "$report_file" || echo "Error: Unable to fetch process data." | tee -a "$report_file"
    else
        echo "Error: 'ps' command not found. Please install procps package." | tee -a "$report_file"
    fi
}

check_top_memory_processes() {
    echo -e "\n**Top 5 Processes by Memory Usage:**" | tee -a "$report_file"
    if command_exists ps; then
        ps -eo pid,comm,%mem --sort=-%mem | head -6 | tee -a "$report_file" || echo "Error: Unable to fetch process data." | tee -a "$report_file"
    else
        echo "Error: 'ps' command not found. Please install procps package." | tee -a "$report_file"
    fi
}

# Main Function
main() {
    echo "========== Server Performance Report ==========" | tee -a "$report_file"

    # Function to display CPU Load
    check_cpu_load
    # Function to display Memory Usage
    check_memory_usage
    # Function to display Disk Usage
    check_disk_usage
    # Function to display Top 5 Processes by CPU Usage
    check_top_cpu_processes
    # Function to display Top 5 Processes by Memory Usage
    check_top_memory_processes

    echo -e "\nReport Generated on: $(date)" | tee -a "$report_file"

    echo -e "\nReport saved to: $report_file"
}

# Execute Main Function
main
