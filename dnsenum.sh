#!/bin/bash

# Function to perform DNS enumeration scan
perform_dnsenum_scan() {
    local option=$1
    local scan_name=$2

    echo "Performing DNS enumeration scan: $scan_name..."
    echo
    dnsenum "$option" "$domain"
    echo
    echo "DNS enumeration scan completed: $scan_name."
    echo
}

# Function to save output to a file
save_output_to_file() {
    read -p "Enter the output file name: " output_file
    echo "Saving output to $output_file..."
    dnsenum -o "$output_file" "$domain"
    echo "Output saved to $output_file."
}

# Function to display the menu options
display_menu() {
    echo "DNS Enumeration Options:"
    echo "------------------------"
    echo "1. Enumeration (Shortcut)"
#    echo "2. Skip Reverse Lookup"
#    echo "3. Disable ANSIColor Output"
#    echo "4. Show and Save Private IPs"
#    echo "5. Write Subdomains to File"
#    echo "6. Set Timeout"
#    echo "7. Set Number of Threads"
#    echo "8. Verbose Output"
#    echo "9. Google Scraping (Pages)"
#    echo "10. Google Scraping (Subdomains)"
#    echo "11. Read Subdomains from File"
#    echo "12. Update Subdomains File"
#    echo "13. Recursion on Subdomains"
#    echo "14. Set WHOIS Query Delay"
#    echo "15. Perform WHOIS Queries"
#    echo "16. Exclude PTR Records"
    echo "0. Exit"
    echo
}

# Function to validate domain
validate_domain() {
    local domain=$1

    if ping -c 1 "$domain" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Main script
clear
echo "Welcome to the DNS Enumeration Script!"
echo

while true; do
    # Prompt user for target domain
    while true; do
        read -p "Enter the target domain: " domain
        echo

        if validate_domain "$domain"; then
            break
        else
            echo "Invalid domain. Please enter a valid domain."
            echo
        fi
    done

    display_menu

    read -p "Enter the scan number (1-17): " scan_option
    echo

    case $scan_option in
        1)
            perform_dnsenum_scan "--enum" "Enumeration (Shortcut)"
            ;;
        2)
            perform_dnsenum_scan "--noreverse" "No Reverse Lookup"
            ;;
        3)
            perform_dnsenum_scan "--nocolor" "Disable ANSIColor Output"
            ;;
        4)
            perform_dnsenum_scan "--private" "Show and Save Private IPs"
            ;;
        5)
            perform_dnsenum_scan "--subfile <file>" "Write Subdomains to File"
            ;;
        6)
            read -p "Enter the timeout in seconds: " timeout
            perform_dnsenum_scan "--timeout $timeout" "Set Timeout"
            ;;
        7)
            read -p "Enter the number of threads: " threads
            perform_dnsenum_scan "--threads $threads" "Set Number of Threads"
            ;;
        8)
            perform_dnsenum_scan "-v, --verbose" "Verbose Output"
            ;;
        9)
            read -p "Enter the number of pages to scan: " pages
            perform_dnsenum_scan "-p $pages" "Google Scraping (Pages)"
            ;;
        10)
            perform_dnsenum_scan "-s, --scrap <value>" "Google Scraping (Subdomains)"
            ;;
        11)
            read -p "Enter the file path: " file_path
            perform_dnsenum_scan "-f $file_path" "Read Subdomains from File"
            ;;
        12)
            perform_dnsenum_scan "-u, --update <a|g|r|z>" "Update Subdomains File"
            ;;
        13)
            perform_dnsenum_scan "-r, --recursion" "Recursion on Subdomains"
            ;;
        14)
            read -p "Enter the delay time in seconds: " delay
            perform_dnsenum_scan "-d $delay" "Set WHOIS Query Delay"
            ;;
        15)
            perform_dnsenum_scan "-w, --whois" "Perform WHOIS Queries"
            ;;
        16)
            perform_dnsenum_scan "-e, --exclude <regexp>" "Exclude PTR Records"
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please enter a valid scan number."
            echo
            ;;
    esac

    echo "Press Enter to continue..."
    read -r
    clear
done
