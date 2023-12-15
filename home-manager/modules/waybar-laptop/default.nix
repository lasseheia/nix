{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pamixer
    pavucontrol
    flameshot
  ];

  services.flameshot.enable = true;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "battery"
          "backlight"
          "cpu"
          "memory"
          "disk#root"
          "disk#home"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "bluetooth"
        ];

        clock = {
          interval = 30;
          format = "{:%Y-%m-%d %H:%M}";
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

        "disk#root" = {
          interval = 5;
          format = "Root {percentage_used}%";
          path = "/";
        };

        "disk#home" = {
          interval = 5;
          format = "Home {percentage_used}%";
          path = "/home";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon}  {percent}%";
          format-icons = ["" ""];
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format-icons = ["" "" "" "" ""];
          format = "{icon}  {capacity}%";
          format-charging = "{icon}  {capacity}% ";
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

      #disk.root {
        color: #b58900;
      }

      #disk.home {
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
