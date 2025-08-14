{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    icecast
  ];

  sops.secrets."icecast/admin_password" = { };
  sops.secrets."icecast/source_password" = { };
  sops.secrets."icecast/relay_password" = { };

  sops.templates."icecast.xml".content = ''
    <icecast>
      <location>Eindhoven</location>
      
      <limits>
          <clients>100</clients>
          <sources>2</sources>
          <threadpool>5</threadpool>
          <queue-size>524288</queue-size>
          <client-timeout>30</client-timeout>
          <header-timeout>15</header-timeout>
          <source-timeout>10</source-timeout>
          <burst-on-connect>1</burst-on-connect>
          <burst-size>65535</burst-size>
      </limits>

      <authentication>
          <!-- Sources log in with username 'source' -->
          <source-password>${config.sops.placeholder."icecast/source_password"}</source-password>
          <!-- Relays log in username 'relay' -->
          <relay-password>${config.sops.placeholder."icecast/relay_password"}</relay-password>
          <admin-user>admin</admin-user>
          <admin-password>${config.sops.placeholder."icecast/admin_password"}</admin-password>
      </authentication>

      <hostname>radio-icecast.gewis.nl</hostname>

      <listen-socket>
          <port>8000</port>
      </listen-socket>

      <http-headers>
        <header name="Access-Control-Allow-Origin" value="*" />
      </http-headers>

      <fileserve>1</fileserve>

      <paths>
          <basedir>${pkgs.icecast}/share/icecast</basedir>
          <logdir>/var/log/icecast</logdir>
          <webroot>${pkgs.icecast}/share/icecast/web</webroot>
          <adminroot>${pkgs.icecast}/share/icecast/admin</adminroot>
      
          <alias source="/" dest="/status.xsl"/>
      </paths>

      <logging>
          <accesslog>access.log</accesslog>
          <errorlog>error.log</errorlog>
          <loglevel>3</loglevel> <!-- 4 Debug, 3 Info, 2 Warn, 1 Error -->
          <logsize>10000</logsize> <!-- Max size of a logfile -->
      </logging>

      <security>
          <chroot>0</chroot>
          <changeowner>
            <user>nobody</user>
            <group>nogroup</group>
          </changeowner>
      </security>
    </icecast>
  '';

  systemd.services.icecast = {
    after = [ "network.target" ];
    description = "Icecast Network Audio Streaming Server";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.icecast}/bin/icecast -c ${config.sops.templates."icecast.xml".path}";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
    };
  };
}
