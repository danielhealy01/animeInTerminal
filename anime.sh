#!/bin/bash

# Define the video options
videos=(
    "Madara vs Shinobi Alliance"
    "Levi vs Beast Titan"
    "Asuka VS Mass Production Eva Series"
    "Goku turns super saiyan for the first time"
    "Luffy Punches World Noble"
    "Gon’s Transformation"
    "Meruem vs. Netero"
    "Eren transforms into the Attack Titan"
    "Rock Lee vs. Gaara"
    "Roy Mustang vs. Lust"
    "Simon’s final fight in space"
    "Erwin's Charge"
    "Araragi vs. Kiss-Shot"
    "Jotaro vs. Dio"
    "Thorfinn vs. Thorkell"
    "Zoro’s "Nothing Happened" moment"
    "Shirou vs. Gilgamesh"
    "Touma vs. Accelerator"
    "Naruto vs. Sasuke"
    "Hisoka vs Gon"
    "Bondrewd vs Reg"
)

# Define the renderer options
renderers=(
    "caca"
    "tct"
)

# Use fzf to display the video menu and capture the selection
selected_video=$(printf "%s\n" "${videos[@]}" | fzf --height=${#videos[@]} --border --ansi --prompt "Select a video: " --color=fg:#f8f8f2,fg+:#282a36,bg+:#50fa7b,hl:#ff79c6,hl+:#ff79c6 --color=info:#8be9fd,pointer:#bd93f9,marker:#50fa7b,spinner:#ffb86c,border:#6272a4)

# Map the selected video to its URL
case $selected_video in
    "Madara vs Shinobi Alliance")
        video_url="https://www.youtube.com/watch?v=zp6xM6Aezmg"
        ;;
    "Levi vs Beast Titan")
        video_url="https://www.youtube.com/watch?v=F0sqfPkCcyM"
        ;;
    "Asuka VS Mass Production Eva Series")
        video_url="https://www.youtube.com/watch?v=kBhbZMHgDqg"
        ;;
    "Goku turns super saiyan for the first time")
        video_url="https://www.youtube.com/watch?v=c7jvWOfwc1M"
        ;;
    "Luffy Punches World Noble")
        video_url="https://www.youtube.com/watch?v=IX2EfnTc_Eg"
        ;;
    "Gon's Transformation")
        video_url="https://www.youtube.com/watch?v=XL2PiVNYD_Y"
        ;;
    "Meruem vs. Netero")
        video_url="https://www.youtube.com/watch?v=-s6trfoS6Mw"
        ;;
    "Eren transforms into the Attack Titan")
        video_url="https://www.youtube.com/watch?v=itKq_Qg-MHM"
        ;;
    "Rock Lee vs. Gaara")
        video_url="https://www.youtube.com/watch?v=rVWFCdrTKUA&t=2s"
        ;;
    "Roy Mustang vs. Lust")
        video_url="https://www.youtube.com/watch?v=O6Nyb9kiZO0"
        ;;
    "Simon’s final fight in space")
        video_url="https://www.youtube.com/watch?v=oMwOIbWIjqk"
        ;;
    "Erwin's Charge")
        video_url="https://www.youtube.com/watch?v=9hh8qaajIXk"
        ;;
    "Araragi vs. Kiss-Shot")
        video_url="https://www.youtube.com/watch?v=mwCS2gWFwdM"
        ;;
    "Jotaro vs. Dio")
        video_url="https://www.youtube.com/watch?v=i-L0Gs2whvc"
        ;;
    "Thorfinn vs. Thorkell")
        video_url="https://www.youtube.com/watch?v=cP4c38S77h4"
        ;;
    "Zoro’s 'Nothing Happened' moment")
        video_url="https://www.youtube.com/watch?v=sAtZoIFW2Uw"
        ;;
    "Shirou vs. Gilgamesh")
        video_url="https://www.youtube.com/watch?v=eKyN_Sox7oM"
        ;;
    "Touma vs. Accelerator")
        video_url="https://www.youtube.com/watch?v=zM6sWIAinXY"
        ;;
    "Naruto vs. Sasuke")
        video_url="https://www.youtube.com/watch?v=qi2rByJed-E"
        ;;
    "Hisoka vs Gon")
        video_url="https://www.youtube.com/watch?v=Txl2imn11bM&t=14s"
        ;;
    "Bondrewd vs Reg")
        video_url="https://www.youtube.com/watch?v=ygZEmWg8jHY"
        ;;                                                              
    *)
        echo "Invalid video selection or cancelled."
        exit 1
        ;;
esac

# Use fzf to display the renderer menu and capture the selection
selected_renderer=$(printf "%s\n" "${renderers[@]}" | fzf --height=10 --border --ansi --prompt "Select a renderer: ")

# Validate the renderer selection
if [[ " ${renderers[@]} " =~ " ${selected_renderer} " ]]; then
    renderer_option=$selected_renderer
else
    echo "Invalid renderer selection or cancelled."
    exit 1
fi

# Build the final command string
command="mpv --vo=$renderer_option $video_url"

# Spinner function
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    tput civis  # Hide cursor
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
    tput cnorm  # Show cursor
}

# Execute the final command with spinner
echo -n "Loading video..."
$command & spinner
wait
