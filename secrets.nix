let
  sebastien = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFAmMXdhIQGvygYIhQv7X05fMTIEY3r6Fkm4ufiZNkH";
in
{
    "secrets/env.age".publicKeys = [ sebastien ];
}
