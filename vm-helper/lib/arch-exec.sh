#!/bin/bash

VM_NAME="arch"

if [ $# -eq 0 ]; then
    echo "Usage: arch-exec <command>"
    exit 1
fi

virsh qemu-agent-command "$VM_NAME" '{
    "execute": "guest-exec",
    "arguments": {
        "path": "/bin/bash",
        "arg": ["-c", "'"$*"'"],
        "capture-output": true
    }
}' | jq -r '.return.pid' > /tmp/arch-exec-pid

sleep 1
PID=$(cat /tmp/arch-exec-pid)
virsh qemu-agent-command "$VM_NAME" '{
    "execute": "guest-exec-status",
    "arguments": {"pid": '"$PID"'}
}' | jq -r '.return["out-data"]' | base64 -d