{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.open-design;
in {
  options.services.open-design = {
    enable = mkEnableOption "Enable the OpenDesign daemon";

    port = mkOption {
      type = types.port;
      default = 7456;
      description = "Exposed port used to access the webapp";
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/open-design 0750 1001 1001 -"
    ];

    virtualisation.oci-containers.containers.open-design = {
      image = "ghcr.io/nexu-io/od:latest";
      ports = [
        "127.0.0.1:${toString cfg.port}:7456"
      ];
      volumes = [
        "/var/lib/open-design:/app/.od"
      ];
      environment = {
        NODE_ENV = "production";
        NODE_OPTIONS = "--max-old-space-size=192";
        OD_BIND_HOST = "0.0.0.0";
        OD_PORT = "7456";
        OD_WEB_PORT = toString cfg.port;
      };

      extraOptions = [
        "--read-only"
        "--tmpfs=/tmp"
        "--security-opt=no-new-privileges:true"
        "--memory=384m"
        "--pids-limit=256"
      ];
    };
  };
}
