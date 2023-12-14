{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pamixer
    pavucontrol
  ];

  programs.waybar = {
    enable = true;
    settings = { mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "memory"
          "cpu"
          "disk"
          "backlight"
          "battery"
          "bluetooth"
        ];

        clock = {
          interval = 60;
          format = "{:%H:%M}";
          max-length = 25;
        };

        pulseaudio = {
          format = "{icon} {volume:2}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "MUTE";
          format-icons = {
            headphones = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };

        memory = {
          interval = 5;
          format = "Mem {}%";
        };

        cpu = {
          interval = 5;
          format = "CPU {usage:2}%";
        };

        disk = {
          interval = 5;
          format = "Disk {percentage_used:2}%";
          path = "/";
        };

        backlight = {
        	device = "intel_backlight";
        	format = "{percent}% {icon}";
        	format-icons = ["" ""];
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };

        bluetooth = {
        	format = " {status}";
        	format-connected = " {device_alias}";
        	format-connected-battery = " {device_alias} {device_battery_percentage}%";
        	tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        	tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        	tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        	tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = ''
            if bluetoothctl show | grep 'Powered: no' -q; then
              bluetoothctl power on
            else
              bluetoothctl power off
            fi
          '';
          on-click-right = "blueman-manager";
        };
      };
    };
    style = ''
      * {
        font-size: 12px;
        font-family: monospace;
        margin: 2px 10px;
      }

      window#waybar {
        background: #292b2e;
        color: #fdf6e3;
      }

      #pulseaudio {
        color: #268bd2;
      }

      #memory {
        color: #2aa198;
      }

      #cpu {
        color: #6c71c4;
      }

      #disk {
        color: #b58900;
      }

      #battery {
        color: #26bfc7
      }

      #backlight {
        color: #d1cec7
      }
    '';
  };
}
