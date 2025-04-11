{
  networking.firewall.allowedTCPPorts = [ 1433 ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      sqlserver = {
        image = "mcr.microsoft.com/mssql/server:2022-latest";
        autoStart = true;
        ports = [ "1433:1433" ]; # Map host port 1433 to container port 1433
        environment = {
          ACCEPT_EULA = "Y"; # Accept the SQL Server EULA
          SA_PASSWORD = "YourStrong@Passw0rd"; # Set a strong password for the SA user
        };
        extraOptions = [ "--network=host" ]; # Use host networking
      };
    };
  };
}
