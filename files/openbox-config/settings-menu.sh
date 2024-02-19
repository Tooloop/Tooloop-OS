#!/bin/bash

echo '<openbox_pipe_menu>'
echo '    <item icon="/home/tooloop/.config/icons/menu_icon_system_settings.png" label="System settings">'
echo '        <action name="Execute">'
echo '            <execute>chromium --disable-features=Translate,Infobars --no-default-browser-check --no-first-run --class="Tooloop Control" --temp-profile --app=http://localhost</execute>'
echo '        </action>'
echo '    </item>'

NVIDIA_INSTALLED="$(which nvidia-settings)"
if [ "${NVIDIA_INSTALLED}" != "" ]; then
    echo '    <item icon="/home/tooloop/.config/icons/menu_icon_nvidia.png" label="Nvidia settings">'
    echo '        <action name="Execute">'
    echo '            <execute>/usr/bin/nvidia-settings</execute>'
    echo '        </action>'
    echo '    </item>'
else
    echo '    <item icon="/home/tooloop/.config/icons/menu_icon_nvidia.png" label="Display settings">'
    echo '        <action name="Execute">'
    echo '            <execute>arandr</execute>'
    echo '        </action>'
    echo '    </item>'
fi

echo '<item icon="/home/tooloop/.config/icons/menu_icon_volume.png" label="Audio volume">'
echo '    <action name="Execute">'
echo '        <execute>pavucontrol</execute>'
echo '    </action>'
echo '</item>'
echo '</openbox_pipe_menu>'
