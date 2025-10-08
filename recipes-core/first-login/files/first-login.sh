trap '' INT HUP TERM
if [ ! -f /etc/first-login-done ]; then
    # Skip password change requirement
    if [ ! -w /etc ]; then
        echo "Insufficient permissions to write to /etc directory."
        exit 1
    fi
    touch /etc/first-login-done
    
    # Make sure services are properly started
    systemctl start android-tools-adbd.service
    systemctl enable android-tools-adbd.service
    systemctl start init_display.service
fi
