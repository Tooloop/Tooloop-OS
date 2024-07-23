#!/bin/bash

echo '<openbox_pipe_menu>'

echo '<item icon="/home/tooloop/.config/openbox-menu-icons/menu_icon_volume.png" label="Audio ">'
echo '    <action name="Execute">'
echo '        <execute>pavucontrol</execute>'
echo '    </action>'
echo '</item>'

NVIDIA_INSTALLED="$(which nvidia-settings)"
if [ "${NVIDIA_INSTALLED}" != "" ]; then
    echo '    <item icon="/home/tooloop/.config/openbox-menu-icons/menu_icon_nvidia.png" label="Nvidia ">'
    echo '        <action name="Execute">'
    echo '            <execute>/usr/bin/nvidia-settings</execute>'
    echo '        </action>'
    echo '    </item>'
else
    echo '    <item icon="/home/tooloop/.config/openbox-menu-icons/menu_icon_display_settings.png" label="Display ">'
    echo '        <action name="Execute">'
    echo '            <execute>arandr</execute>'
    echo '        </action>'
    echo '    </item>'
fi

echo '    <item icon="/home/tooloop/.config/openbox-menu-icons/menu_icon_system_settings.png" label="System ">'
echo '        <action name="Execute">'
echo '            <execute>chromium --disable-features=Translate,Infobars --no-default-browser-check --no-first-run --class="Tooloop Control" --temp-profile --app=http://localhost</execute>'
echo '        </action>'
echo '    </item>'

echo '</openbox_pipe_menu>'