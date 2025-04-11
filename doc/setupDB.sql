drop schema apivanilla;
create schema apiVanilla;
use apiVanilla;
create user vanilla@127.0.0.1 identified by 'vanillaUser';
Grant all privileges on apiVanilla .* to vanilla@127.0.0.1;
flush privileges;