#!/bin/bash

#echo space.sh $'FOCUSED_WORKSPACE': $FOCUSED_WORKSPACE, $'SELECTED': $SELECTED, NAME: $NAME, SENDER: $SENDER  >> ~/aaaa

AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
AEROSPACE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
AEROSPACE_EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)

reload_workspace_icon() {
  # echo reload_workspace_icon "$@" >> ~/aaaa
  apps=$(aerospace list-windows --workspace "$@" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  icon_img=""
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
      icon_img="app.$app"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --set space.$@ \
    icon.background.drawing=on \
    icon.background.image="$icon_img" \
    icon.background.image.padding_left=35 \
    icon.background.image.scale=0.5
}

update() {
  # 처음 시작에만 작동하기 위해서
  # 현재 forced, space_change 이벤트가 동시에 발생하고 있다.
  # if [ "$SENDER" = "aerospace_workspace_change" ]; then
    #echo space.sh $'FOCUSED_WORKSPACE': $FOCUSED_WORKSPACE, $'SELECTED': $SELECTED, NAME: $NAME, SENDER: $SENDER, INFO: $INFO  >> ~/aaaa
    #echo $(aerospace list-workspaces --focused) >> ~/aaaa
    source "$CONFIG_DIR/colors.sh"
    # COLOR=$BACKGROUND_2
    # if [ "$SELECTED" = "true" ]; then
    #   COLOR=$GREY
    # fi
    # sketchybar --set $NAME icon.highlight=$SELECTED \
    #                        label.highlight=$SELECTED \
    #                        background.border_color=$COLOR
    
  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$FOCUSED_WORKSPACE"

  sketchybar --set space.$FOCUSED_WORKSPACE icon.highlight=true \
                    label.highlight=true \
                    background.border_color=$GREY

  sketchybar --set space.$AEROSPACE_PREV_WORKSPACE icon.highlight=false \
                         label.highlight=false \
                         background.border_color=$BACKGROUND_2

  for i in $AEROSPACE_WORKSPACE_FOCUSED_MONITOR; do
    sketchybar --set space.$i \
      display=$AEROSPACE_FOCUSED_MONITOR
  done

  for i in $AEROSPACE_EMPTY_WORKSPACE; do
    sketchybar --set space.$i \
      icon.background.drawing=off
  done

  # sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR
  #
  #   apps=$(aerospace list-windows --workspace "$FOCUSED_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  #
  #   icon_strip=" "
  #   if [ "${apps}" != "" ]; then
  #     while read -r app
  #     do
  #       icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  #     done <<< "${apps}"
  #   else
  #     icon_strip=" test"
  #   fi
  #
  #   sketchybar --set space.$FOCUSED_WORKSPACE label="$icon_strip"
  # fi
  #
  # sketchybar --set space.$AEROSAPCE_WORKSPACE_FOCUSED_MONITOR display=$AEROSPACE_FOCUSED_MONITOR
}

# set_space_label() {
#   sketchybar --set $NAME icon="$@"
# }
#
# mouse_clicked() {
#   if [ "$BUTTON" = "right" ]; then
#     # yabai -m space --destroy $SID
#     echo ''
#   else
#     if [ "$MODIFIER" = "shift" ]; then
#       SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
#       if [ $? -eq 0 ]; then
#         if [ "$SPACE_LABEL" = "" ]; then
#           set_space_label "${NAME:6}"
#         else
#           set_space_label "${NAME:6} ($SPACE_LABEL)"
#         fi
#       fi
#     else
#       #yabai -m space --focus $SID 2>/dev/null
#       #echo space.sh BUTTON: $BUTTON, $'SELECTED': $SELECTED, MODIFIER: $MODIFIER, NAME: $NAME, SENDER: $SENDER, INFO: $INFO, TEST: ${NAME#*.}, ${NAME:6} >> ~/aaaa
#       aerospace workspace ${NAME#*.}
#     fi
#   fi
# }

# echo plugin_space.sh $SENDER >> ~/aaaa
case "$SENDER" in
  # "mouse.clicked") mouse_clicked
  # ;;
  *) update
  ;;
esac
