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
          "cpu"
          "memory"
          "custom/gpu-usage"
          "disk#root"
          "disk#home"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "pulseaudio"
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

        cpu = {
          interval = 5;
          format = "CPU {usage:2}%";
        };

        memory = {
          interval = 5;
          format = "Mem {}%";
        };

        "custom/gpu-usage" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          format = "GPU {}%";
          return-type = "";
          interval = 5;
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
      };
    };
    style = ''
      * {
        font-size: 12px;
        font-family: monospace;
        margin: 2px 10px;
      }

      window#waybar {
        background: #32353B;
        color: #ECEFF4;
      }

      #pulseaudio {
        color: #4C7899;
      }

      #cpu {
        color: #C678DD;
      }

      #memory {
        color: #56B6C2;
      }

      #custom-gpu-usage {
        color: #64C221;
      }

      #disk.root {
        color: #E5C07B;
      }

      #disk.home {
        color: #D19A66;
      }
    '';
  };
}
