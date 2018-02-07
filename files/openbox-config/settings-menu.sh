#!/bin/bash

echo '<openbox_pipe_menu>'
echo '    <item icon="/home/tooloop/.config/icons/menu_icon_system_settings.png" label="System settings">'
echo '        <action name="Execute">'
echo '            <execute>chromium-browser --app=http://localhost</execute>'
echo '        </action>'
echo '    </item>'

NVIDIA_INSTALLED="$(which nvidia-settings)"
if [ "${NVIDIA_INSTALLED}" != "" ]; then

    echo '    <item icon="/home/tooloop/.config/icons/menu_icon_nvidia.png" label="Nvidia settings">'
    echo '        <action name="Execute">'
    echo '            <execute>/usr/bin/nvidia-settings</execute>'
    echo '        </action>'
    echo '    </item>'

fi

echo '<item icon="/home/tooloop/.config/icons/menu_icon_volume.png" label="Audio volume">'
echo '    <action name="Execute">'
echo '        <execute>pavucontrol</execute>'
echo '    </action>'
echo '</item>'
echo '</openbox_pipe_menu>'
