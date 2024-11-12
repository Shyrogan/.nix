{ config, ...}: {
  age = {
    secrets = {
      wifis.file = ../../secrets/wifi.secrets;
    };
    identityPaths = [ "/etc/ssh/id_ed25519" ];
  };
  
  networking = {
    wireless = {
      enable = true;
      userControlled.enable = true;
      secretsFile = config.age.secrets.wifis.path;
      networks = {
        eduroam = {
          auth = ''
          identity="sebastien.vial@etu.umontpellier.fr"
          password=ext:EDUROAM_PSK
          key_mgmt=WPA-EAP
          pairwise=CCMP
          group=CCMP TKIP
          eap=PEAP
          ca_cert="${../../assets/eduroam.pem}"
          altsubject_match="DNS:wifi.umontpellier.fr"
          phase2="auth=MSCHAPV2"
          '';
        };
        SFR-a470_5GHz = {
          auth = ''
          psk=ext:SFR_AP_PSK
          '';
        };
        Freebox-517A5B = {
          auth = ''
          psk=ext:AMBER_PASSWORD
          '';
        };
        Freebox-maison = {
          auth = ''
          psk=ext:PARENT_PASSWORD
          '';
        };
      };
    };
  };
} 
