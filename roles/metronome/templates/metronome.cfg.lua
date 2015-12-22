-- ** Metronome's config file example **
--
-- Le format du fichier est exactement identique a Prosody.
--
-- Une liste s'ecrit { "like", "this", "one" }
-- Lists can also be of { 1, 2, 3 } numbers, etc.
-- LEs virgules, et poitn virgules; peuvent etre utilisé comme separateurs.
--
-- A table is a list of values, except each value has a name. An
-- example would be:
--
-- ssl = { key = "keyfile.key", certificate = "certificate.cert" }
--
-- Tip: You can check that the syntax of this file is correct when you have finished
-- by running: luac -p metronome.cfg.lua
-- If there are any errors, it will let you know what and where they are, otherwise it
-- will keep quiet.

-- Global settings go in this section

-- This is the list of modules Metronome will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.

modules_enabled = {
	-- Plugins generallement requis
	"roster";
	"saslauth";     -- Authentification des clients et serveurs
	"tls";          -- Support de TLS sur les connections C2S / S2S
	"dialback";     -- Support du dialback S2S
	"disco";        -- Decouverte des services

	-- Non essentiel, mais recommander
	"private";
	"vcard";
	"pep";
	"bidi";

	-- Modules HTTP
	"bosh";         -- Autorise les clients BOSH (Jabber sur HTTP)

	-- Modules facultatifs mais interessants
	"version";      -- Repond aux requetes de version
	"uptime";       -- Indique l'uptime serveur
	"time";         -- Permet de connaitre la date serveur
	"ping";         -- Repond aux pings XMPP par des pongs

	-- Autres fonctionnalites specifiques
	"posix";        -- Fonctionnalites POSIX (run in background, syslog, etc)
	"admin_web";	-- administration web interface
};

-- Mod_disco permet l'auto-configuration de certains services
-- Facultatif si les services en question ne sont pas actifs...
disco_items = {
	{
		"muc.mon-domaine.fr" -- Multi-User Chat
	},
	{
		"vjud.mon-domaine.fr" -- Jabber Users Directory (annuaire de recherche)
	},
	{
		"pubsub.mon-domaine.fr" -- Fonctions de micro-blogging XMPP
	}
};

-- Default pidfile path
pidfile = "/var/run/metronome/metronome.pid";

-- Liste des comptes administrateurs du serveur
-- Example: admins = { "valerian@jappix.com", "julien@jappix.com" }
admin = { "admin@mon-domaine.fr" }

-- ulimit
metronome_max_files_soft = 200000;
metronome_max_files_hard = 200000;

use_libevent = true;

-- Liste des modules charges par Metronome au demarrage.
-- Ils sont normalement places dans le dossier plugins de Metronome sous la forme mod_modulename.lua
allow_registration = false;

https_ports = { 5281 };

bosh_ports = {
        {
                port = 5281;
                path = "http-bind";
        }
};

force_https_bosh = true
cross_domain_bosh = true
bosh_max_inactivity = 30
consider_bosh_secure = true

-- Configuration SSL
ssl = {
        key = "/usr/local/etc/metronome/certs/localhost.key";
        certificate = "/usr/local/etc/metronome/certs/localhost.cert";
};

-- Chiffrement requis Client to Server (c2s)
-- Chiffrement requis Server to Server (s2s)
c2s_require_encryption = true;
s2s_require_encryption = true;

authentication = "internal_hashed";

-- Gestion des logs
log = {
        info  = "/var/log/metronome/metronome.log";     -- Pour le debugging, modifier info par debug
        error = "/var/log/metronome/metronome.err";
        -- "*syslog";
};
