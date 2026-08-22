#!/bin/bash
# Fetch system stats for Omarchy waybar-like widget

# 1. Temperature
temp=$(sensors 2>/dev/null | grep -m 1 "Package id 0:" | awk '{print $4}' | tr -d '+')
[ -z "$temp" ] && temp=$(sensors 2>/dev/null | grep -m 1 "temp1:" | awk '{print $2}' | tr -d '+')
[ -z "$temp" ] && temp="N/A"
temp="${temp} "

# 2. Power Profile
profile=$(powerprofilesctl get 2>/dev/null)
if [ "$profile" = "performance" ]; then
    power=""
elif [ "$profile" = "balanced" ]; then
    power=""
else
    power=""
fi

# 3. CPU
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
total1=$((user+nice+system+idle+iowait+irq+softirq+steal))
idle1=$((idle+iowait))
sleep 0.1
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
total2=$((user+nice+system+idle+iowait+irq+softirq+steal))
idle2=$((idle+iowait))
total_diff=$((total2-total1))
idle_diff=$((idle2-idle1))
if [ "$total_diff" -eq 0 ]; then
  cpu="0"
else
  cpu=$((100*(total_diff-idle_diff)/total_diff))
fi
cpu="${cpu}% 󰍛"

# 4. Memory
mem=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100.0}')
mem="${mem}% 󰘚"

# 5. Disk
disk=$(df --output=pcent / | tail -n 1 | tr -d ' %')
disk="${disk}% 󰋊"

# 6. Uptime
up=$(awk '{d=int($1/86400); h=int(($1%86400)/3600); m=int(($1%3600)/60); if(d>0) printf "%dd ", d; if(h>0) printf "%dh ", h; printf "%dm", m}' /proc/uptime)
up="${up} 󰔚"

# JSON output
jq -n -c \
  --arg temp "$temp" \
  --arg power "$power" \
  --arg cpu "$cpu" \
  --arg mem "$mem" \
  --arg disk "$disk" \
  --arg uptime "$up" \
  '{temp: $temp, power: $power, cpu: $cpu, mem: $mem, disk: $disk, uptime: $uptime}'
